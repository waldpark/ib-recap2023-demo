using { API_PRODUCT_SRV as externalProductService } from './external/API_PRODUCT_SRV.csn';

service OnPremiseService {
    @readonly entity Products as projection on externalProductService.A_Product {
        *
    }

}
