
package com.example.service;

import com.example.dto.PatientDto;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.nio.file.*;
import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class QrSyncService {

    private final RestTemplate restTemplate = new RestTemplate();

    @Value("${qr.source-json-url}")
    private String jsonUrl;

    @Value("${qr-code-link}")
    private String qrCodeLink;

    @Value("${qr.storage-root}")
    private String storageRoot;

    public Map<String, Integer> sync() throws IOException, WriterException {

        // json lecture
        PatientDto[] patients = restTemplate.getForObject(jsonUrl, PatientDto[].class );

        if (patients == null) {
            throw new IOException("Réponse JSON vide");
        }

        int generated = 0;
        int existing = 0;
        int invalid = 0;

        for (PatientDto patient : patients) {

            if (patient == null || patient.getId() == null) {
                invalid++;
                continue;
            }

            String id = patient.getId().trim();
            if (!id.matches("[a-zA-Z0-9_-]+")) {
                invalid++;
                continue;
            }

            Path directory = Paths.get(storageRoot,id,"QrCode");
            // usr/locale/medecin/{id}/QrCode

            Path file = directory.resolve(id + "QrCode");

            if (Files.isRegularFile(file)) { existing++;continue; }

            if (Files.exists(file)) {
                throw new IOException(
                    "Chemin occupé par un fichier non régulier : "
                    + file
                );
            }

            Files.createDirectories(directory);
            String url = qrCodeLink + id;
            QRCodeWriter writer = new QRCodeWriter();

            BitMatrix matrix = writer.encode(url,BarcodeFormat.QR_CODE,300,300);
            
            // fichier temporaire
            Path temp = Files.createTempFile(directory, "qr-", ".tmp");

            try {
                MatrixToImageWriter.writeToPath(matrix,"PNG",temp);

                // deplacer le fichier temporaire
                try {
                    Files.move(temp, file,StandardCopyOption.ATOMIC_MOVE);
                } catch (AtomicMoveNotSupportedException e) {
                    Files.move(temp, file);
                }

            } finally {
                Files.deleteIfExists(temp);
            }

            generated++;
        }

        Map<String, Integer> result =new LinkedHashMap<String, Integer>();

        result.put("total", patients.length);
        result.put("generated", generated);
        result.put("existing", existing);
        result.put("invalid", invalid);

        return result;
    }
}
