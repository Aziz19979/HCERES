package org.centrale.hceres.controller;

import org.centrale.hceres.items.Status;
import org.centrale.hceres.service.StatusService;
import org.centrale.hceres.util.RequestParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@RestController
@CrossOrigin(originPatterns = "*")
public class StatusController {

    @Autowired

    private StatusService statusService;

    /**
     * return a list of status of specified type only
     */

    /**
     public List<Status> getStatus() {
     return statusService.getStatus();
     }
     */
    @GetMapping("/Status")
    public List<Status> getStatus() {
        return statusService.getStatus();
    }
    /**
     * create a status in database
     *
     * @return Status
     */
    @PostMapping(value = "/Status/Create")
    public Status createStatus(@RequestBody Map<String, Object> request) throws RequestParseException {
        return statusService.saveStatus(request);
    }

    /**
     * Delete - Delete a status
     *
     * @param id - The id of the status
     */
    @DeleteMapping("/Status/Delete/{id}")
    public void deleteStatus(@RequestBody @PathVariable("id") final Integer id) {
        statusService.deleteStatus(id);
    }
}