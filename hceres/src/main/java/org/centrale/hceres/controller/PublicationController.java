package org.centrale.hceres.controller;

import org.centrale.hceres.items.Publication;
import org.centrale.hceres.service.PublicationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.util.Map;
import java.util.Optional;

@RestController
@CrossOrigin
@RequestMapping("/Publication")
public class PublicationController {

    @Autowired
    private PublicationService publicationService;

    @GetMapping
    public Iterable<Publication> getPublications(){
        return publicationService.getPublications();

    }

    @GetMapping("{id}")
    public Publication getPublication(@PathVariable("id") final Integer id){

        Optional<Publication> publication = publicationService.getPublication(id);
        if(publication.isPresent()){
            return publication.get();
        } else {
            return null;
        }
    }

    @PostMapping(value ="/AddPublication")
    public Publication addPublication(@RequestBody Map<String, Object> request) throws ParseException {

        return publicationService.savePublication(request);
    }
}
