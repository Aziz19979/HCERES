package org.centrale.hceres.controller;

import javax.servlet.http.HttpServletRequest;

import org.centrale.hceres.items.Activity;
import org.centrale.hceres.items.OralCommunication;
import org.centrale.hceres.service.OralCommunicationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

@RestController
@CrossOrigin(originPatterns = "*")
public class OralCommunicationController {
		
	/**
	 * instanciation
	 */
	@Autowired
	private OralCommunicationService communicationService;

	@GetMapping(value = "/OralCommunications")
	public List<Activity> getOralCommunications() {
		return communicationService.getOralCommunications();
	}

	/**
	 * ajouter un elmt a la base de donnees
	 * @return l'elmt ajoute
	 */
	@PostMapping(value ="/OralCommunication/Create")
	public Activity createOralCommunication(@RequestBody Map<String, Object> request) throws ParseException {
		return communicationService.saveOralCommunication(request);
	}

	@DeleteMapping("/OralCommunication/Delete/{id}")

	public void deleteOralCommunication(@RequestBody @PathVariable("id") final Integer id) {
		communicationService.deleteOralCommunication(id);
	}
}
