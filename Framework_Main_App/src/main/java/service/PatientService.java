package service;

import java.util.List;

import config.JpaUtil;
import entities.Patient;
import repositories.PatientRepository;

public class PatientService {

    private PatientRepository patientRepository;

    public PatientService() {
        this.patientRepository = JpaUtil.getRepository(PatientRepository.class);
    }

    public void savePatient(Patient patient) {
        patientRepository.save(patient);
    }

    public Patient getPatientById(Long id) {
        return patientRepository.findById(id).orElse(null);
    }
    
    public List<Patient> getAllPatients() {
        return patientRepository.findAll();
    }

    public void deletePatient(Long id) {
        patientRepository.deleteById(id);
    }
}