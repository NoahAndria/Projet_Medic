

package com.example.controller;

import com.example.service.QrSyncService;
import com.google.zxing.WriterException;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.Map;

@RestController
@RequestMapping("/api/qr")
public class QrController {

    private final QrSyncService service;

    public QrController(QrSyncService service) {
        this.service = service;
    }

    @PostMapping("/sync")
    public Map<String, Integer> sync() throws IOException, WriterException {

        return service.sync();
    }
}
