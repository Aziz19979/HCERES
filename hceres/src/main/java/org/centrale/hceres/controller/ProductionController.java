package org.centrale.hceres.controller;

import java.text.ParseException;
import java.util.Date;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;


import org.centrale.hceres.service.ProductionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

//items
import org.centrale.hceres.items.ToolProduct;

// Controller permet de receptionner la requete http depuis le client, envoyer cette requete a service pour la traiter, puis retouner la reponse
// la reponse sera sous format JSON (il s'agit d'une REST API)
@RestController
@RequestMapping("/Production")
@CrossOrigin
public class ProductionController {
	
	/**
	 * instanciation
	 */
	@Autowired
	private ProductionService productService;
	
	/**
	 * pour une requete GET pour fournir la liste 
	 * @return : la liste
	 */
	@GetMapping
	public Iterable<ToolProduct> getToolProduct() {

		return productService.getToolProduct();
	}

	/**
	 * avoir un elmt grace a son id
	 * @param id : id de l'elmt
	 * @return : l'elmt 
	 */
	@GetMapping("/{id}")
	public ToolProduct getToolProduct(@PathVariable("id") final Integer id) {
		Optional<ToolProduct> product = productService.getToolProduct(id);
		if(product.isPresent()) {
			return product.get();
		} else {
			return null;
		}
	}
	
	/**
	 * ajouter un elmt a la base de donnees
	 * @return l'elmt ajoute
	 */
	@PostMapping("/AddProduction")
	public ToolProduct createToolProduct(@RequestBody Map<String, Object> request) throws ParseException {
		return productService.saveToolProduct(request);
	}
	
	
	/**
	 * Delete - Delete an element
	 * @param id - The id of the element
	 */
	@DeleteMapping("/deleteProduction/{id}")
	public void deleteToolProduct(@PathVariable("id") final Integer id) {
		productService.deleteToolProduct(id);;
	}
}
