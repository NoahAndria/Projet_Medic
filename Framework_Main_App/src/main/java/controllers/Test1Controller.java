package controllers;

import myframework.annotations.Controller;
import myframework.annotations.RestAPI;
import myframework.annotations.UrlMapping;
import myframework.annotations.Auth;

import myframework.utils.Session;
import myframework.utils.ModelView;
import myframework.utils.MapFile;

import entities.Jouet;

import java.util.Arrays;
import java.util.List;

import config.JpaUtil;
import repositories.PatientRepository;

@Controller
public class Test1Controller {


    @UrlMapping(name = "/dobe", method = "GET")
    public ModelView test(Session session) {
        System.out.println("\n test of test1controller in get ");
        session.set("testsession", "test-session-1234");
        // session.set("managerId", 1);
        // s.set("userId", 1);
        System.out.println("AFTER SET: " + session.get("testsession"));
        ModelView mv = new ModelView("form");

        // List<String> names = Arrays.asList("Jean", "Rakoto", "Tahiry", "Noah", "TEST");

        // mv.addAttribute("names", names);

        return mv;
    }

    @UrlMapping(name = "/dobe2", method = "GET")
    @Auth(roles = {"Admin", "Manager"})
    public ModelView test1(Jouet j, String randomInput, Session session) {
        System.out.println("\n test of test2controller in get ");
        System.out.println("You are redirected to dobe2");

        System.out.println("READ IN /dobe2: " + session.get("testsession"));
        
        ModelView mv = new ModelView("result");

        mv.addAttribute("jouet", j);
        mv.addAttribute("randomInput", randomInput);
        mv.addAttribute("st", session.get("testsession"));

        return mv;
    }


    @UrlMapping(name = "/login", method = "GET")
    public ModelView testlogin(Session s) {
        System.out.println("\n test of test1controller in get ");
        s.set("userId", 1);
        s.set("managerId", 1);
        s.set("adminId", 1);
        ModelView mv = new ModelView("random");

        return mv;
    }

    @UrlMapping(name = "/logout", method = "GET")
    public ModelView testlogout(Session s) {
        System.out.println("\n test of test1controller in get ");
        s.remove("userId");
        s.remove("managerId");
        s.remove("adminId");
        ModelView mv = new ModelView("random2");

        return mv;
    }

    // @UrlMapping(name = "/dobe3", method = "POST")
    // public ModelView test2(MapFile testMap, Jouet j, Session session) {
    //     System.out.println("\n test of test1controller in get ");
    //     System.out.println("You are redirected to dobe3");

    //     session.set("st", "stbr");
    //     ModelView mv = new ModelView("result");
    //     mv.addAttribute("mapfile", testMap);
    //     mv.addAttribute("jouet", j);
        
    //     return mv;
    // }

    
    // @UrlMapping(name = "/andrana", method = "GET")
    // public ModelView hehe() {
    //     System.out.println("\n test of test1controller in get ");

    //     ModelView mv = new ModelView("random2");

    //     List<String> names = Arrays.asList("Jean", "Rakoto", "Tahiry", "Noah");

    //     mv.addAttribute("names", names);

    //     return mv;
    // }

    // @UrlMapping(name = "/testapi", method = "GET")
    // @RestAPI
    // public List<Jouet> hi() {
    //     System.out.println("\n test of test1controller in get ");

    //     List<Jouet> jouets = Arrays.asList(
    //         new Jouet("Voiture", 2000, "Fiara kely"),
    //         new Jouet("Puzzle", 12000, "Puzzle 1000 piece"),
    //         new Jouet("Ballon", 5000, "Ballon rouge")
    //     );

    //     return jouets;
    // }

    // @UrlMapping(name = "/testapistr", method = "GET")
    // @RestAPI
    // public String histr() {
    //     System.out.println("\n test of test1controller in get ");


    //     return "test api reussi";
    // }
}
