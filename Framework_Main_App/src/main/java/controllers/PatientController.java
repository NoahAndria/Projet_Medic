package controllers;

import myframework.annotations.Controller;
import myframework.annotations.RestAPI;
import myframework.annotations.UrlMapping;
import myframework.annotations.Auth;

import myframework.utils.Session;
import myframework.utils.ModelView;
import myframework.utils.MapFile;

import entities.Patient;

import java.util.Arrays;
import java.util.List;

import service.PatientService;

@Controller
public class PatientController {

    @UrlMapping(name = "/", method = "GET")
    public ModelView index() {
        System.out.println("\n viewPatient in patientcontroller using post ");
        ModelView mv = new ModelView("patient/viewAll");
        PatientService patientService = new PatientService();
        List<Patient> patients = patientService.getAllPatients();
        mv.addAttribute("patients", patients);
        return mv;
    }

    @UrlMapping(name = "/patient/new", method = "GET")
    public ModelView insertPatient() {
        System.out.println("\n viewPatient in patientcontroller using post ");
        ModelView mv = new ModelView("index");

        return mv;
    }


    @UrlMapping(name = "/patient/save", method = "GET")
    public ModelView savePatient(Patient p) {
        System.out.println("\n savePatient in patientcontroller using post ");
        ModelView mv = new ModelView("index");
        PatientService patientService = new PatientService();
        patientService.savePatient(p);
        return mv;
    }

    @UrlMapping(name = "/patient/delete", method = "GET")
    public ModelView deletePatient(Long id) {
        System.out.println("\n deletePatient in patientcontroller using post ");
        PatientService patientService = new PatientService();
        Patient p = patientService.getPatientById(id);
        patientService.deletePatient(p);

        ModelView mv = new ModelView("patient/viewAll");

        List<Patient> patients = patientService.getAllPatients();
        mv.addAttribute("patients", patients);
        return mv;
    }

    @UrlMapping(name = "/patient/view", method = "GET")
    public ModelView viewPatient(Long id) {
        System.out.println("\n viewPatient in patientcontroller using post ");
        ModelView mv = new ModelView("patient/view");
        PatientService patientService = new PatientService();
        Patient p = patientService.getPatientById(id);
        mv.addAttribute("patient", p);
        return mv;
    }

    @UrlMapping(name = "/patient/update", method = "GET")
    public ModelView viewPatient(Patient p) {
        System.out.println("\n viewPatient in patientcontroller using post ");

        PatientService patientService = new PatientService();
        patientService.savePatient(p);

        ModelView mv = new ModelView("patient/viewAll");

        List<Patient> patients = patientService.getAllPatients();
        mv.addAttribute("patients", patients);
        return mv;
    }

    @UrlMapping(name = "/api/patient/all", method = "GET")
    @RestAPI
    public List<Patient> getAllPatients() {
        System.out.println("\n getAllPatients in patientcontroller using get ");
            
        PatientService patientService = new PatientService();
        List<Patient> patients = patientService.getAllPatients();
        
        return patients;
    }

    @UrlMapping(name = "/api/patient/get", method = "GET")
    @RestAPI
    public Patient getPatient(Long id) {
        System.out.println("\n getPatient in patientcontroller using get ");
            
        PatientService patientService = new PatientService();
        Patient patient = patientService.getPatientById(id);
        
        return patient;
    }



}
