package pl.sda.pms.productConfiguration;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import org.hibernate.envers.Audited;

import pl.sda.pms.productFeature.ProductFeature;

@Entity
@Audited
public class ProductConfiguration{
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	@Column(unique = true)
	private String name;
	@OneToMany
	private List<ProductFeature> configurationList;
	
	public List<ProductFeature> getConfigurationList() {
		return configurationList;
	}


	public void setConfigurationList(List<ProductFeature> configurationList) {
		this.configurationList = configurationList;
	}


	public ProductConfiguration() {
		super();
	}
	

	public ProductConfiguration(String name) {
		super();
		this.name = name;
	}


	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}


	
	

	
	
}