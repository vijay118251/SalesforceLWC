import { LightningElement,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import NF_LOGO from '@salesforce/resourceUrl/netflixLogo';
export default class ContainerPoints extends  NavigationMixin(LightningElement) {
    
    @api pageName;
    @api planType;
    @api recId;
    pageParams = {};
    enablePointsDetails = true;
    image = NF_LOGO;

    handleOnIconClick(event) {
        this.pageParams = {
            tabName: event.currentTarget.dataset.page,
            navigationPage:event.currentTarget.dataset.navigation,
            rewardName:event.currentTarget.dataset.rewardname
        };
        console.log('img clicked',this.pageParams);
        if(this.pageParams && this.pageParams.tabName=='Points_Page') {
            this.redirectToNavPage(this.pageParams.tabName,this.pageParams.navigationPage,this.pageParams.rewardName=='Points');
        }

    }

    redirectToNavPage(tabName,navigationPage,rewardName) {
        console.log('redirectToNavPage method call');
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: tabName,
            },
            state: {
            c__pageName: this.pageName,
            c__planType: this.planType,
            c__recId: this.recId
        }
        });
        this.handleNavigation(rewardName);
    }
}