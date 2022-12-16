package org.centrale.hceres.controller;


import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.SrAward;
import org.centrale.hceres.service.SrAwardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@CrossOrigin(originPatterns = "*")
public class SrAwardController {

    @Autowired
    SrAwardService SrAwardService;


    @GetMapping("/SrAwards")
    public List<Activity> getSrAwards() {
        return SrAwardService.getSrAwards();
    }


    @GetMapping("Api/SrAward/{id}")
    public SrAward getSrAward(@PathVariable("id") final Integer id) {
        Optional<SrAward> SrAward = SrAwardService.getSrAward(id);
        if(SrAward.isPresent()) {
            return SrAward.get();
        } else {
            return null;
        }
    }

    @PostMapping(value = "/SrAward/Create")
    public Activity createSrAward(@RequestBody Map<String, Object> request) throws ParseException {
        return SrAwardService.saveSrAward(request);
    }

    /**
     * Delete - Delete an element
     *
     * @param id - The id of the element
     */
    @DeleteMapping("/SrAward/Delete/{id}")

    public void deleteSrAward(@RequestBody @PathVariable("id") final Integer id) {
        SrAwardService.deleteSrAward(id);
    }

}
