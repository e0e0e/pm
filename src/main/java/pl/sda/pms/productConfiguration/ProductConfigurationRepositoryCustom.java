package pl.sda.pms.productConfiguration;

import java.util.List;

public interface ProductConfigurationRepositoryCustom {

	List<ProductConfiguration> findProductByChoosenFeatyres(List<String> QueryCd);
}