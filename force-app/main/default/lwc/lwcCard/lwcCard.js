import { LightningElement,track } from 'lwc';

export default class LwcCard extends LightningElement {
    @track card=[

        {
        
        id: 1,
        
        subtitle: 'There are many variations of passages of Lorem Ipsum available. Making this the first true generator on the Internet.',
        
        imageURL: 'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg',
        
        fbLogoURL: 'https://ww2.freelogovectors.net/wp-content/uploads/2023/03/facebook-logo-new-2019-freelogovectors.net_.png',
        
        fbProfileURL: 'https://www.facebook.com/Caleb.Santillan378',
        
        linkedinLogoURL: 'https://i.pinimg.com/1200x/cd/3e/d5/cd3ed5a95ef5ac1d694899a51798874b.jpg',
        
        linkedinProfileURL: 'https://www.linkedin.com/in/Test-subhra/'
        
        },
        
        {
        
        id: 2,
        
        subtitle: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Making this the first true generator on the Internet.',
        
        imageURL: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiqZCOyJMqGraHiwB0T-0ggN4i8yCJA49mHw&usqp=CAU',
        
        fbLogoURL: 'https://ww2.freelogovectors.net/wp-content/uploads/2023/03/facebook-logo-new-2019-freelogovectors.net_.png',
        
        fbProfileURL: 'https://www.facebook.com/profile.php?=1000000982382772',
        
        linkedinLogoURL: 'https://i.pinimg.com/1200x/cd/3e/d5/cd3ed5a95ef5ac1d694899a51798874b.jpg',
        
        linkedinProfileURL: 'https://in.linkedin.com/in/dummy-link-775982111?original_referer=https%3A%2F%2Fwww.google.com%2F02'
        
        },
        
        {
        
        id: 3,
        
        subtitle: 'It is a long established fact that a reader will be distracted. Making this the first true generator on the Internet.',
        
        imageURL: 'https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/profile-photos-4.jpg',
        
        fbLogoURL: 'https://ww2.freelogovectors.net/wp-content/uploads/2023/03/facebook-logo-new-2019-freelogovectors.net_.png',
        
        fbProfileURL: 'https://www.facebook.com/profile.php?=1000000982382773',
        
        linkedinLogoURL: 'https://i.pinimg.com/1200x/cd/3e/d5/cd3ed5a95ef5ac1d694899a51798874b.jpg',
        
        linkedinProfileURL: 'https://in.linkedin.com/in/dummy-link-775982111?original_referer=https%3A%2F%2Fwww.google.com%2F03'
        
        },
        
        {
        
        id: 4,
        
        subtitle: 'This masterpiece is renowned for its swirling, turbulent. Making this the first true generator on the Internet.',
        
        imageURL: 'https://www.perfocal.com/blog/content/images/2021/01/Perfocal_17-11-2019_TYWFAQ_100_standard-3.jpg',
        
        fbLogoURL: 'https://ww2.freelogovectors.net/wp-content/uploads/2023/03/facebook-logo-new-2019-freelogovectors.net_.png',
        
        fbProfileURL: 'https://www.facebook.com/profile.php?=1000000982382774',
        
        linkedinLogoURL: 'https://i.pinimg.com/1200x/cd/3e/d5/cd3ed5a95ef5ac1d694899a51798874b.jpg',
        
        linkedinProfileURL: 'https://in.linkedin.com/in/dummy-link-775982111?original_referer=https%3A%2F%2Fwww.google.com%2F04'
        
        },
        
        {
        
        id: 5,
        
        subtitle: 'This masterpiece is renowned for its swirling, turbulent. Making this the first true generator on the Internet.',
        
        imageURL: 'https://cdn.pixabay.com/photo/2014/09/17/11/47/man-449406_640.jpg',
        
        fbLogoURL: 'https://ww2.freelogovectors.net/wp-content/uploads/2023/03/facebook-logo-new-2019-freelogovectors.net_.png',
        
        fbProfileURL: 'https://www.facebook.com/profile.php?=1000000982382774',
        
        linkedinLogoURL: 'https://i.pinimg.com/1200x/cd/3e/d5/cd3ed5a95ef5ac1d694899a51798874b.jpg',
        
        linkedinProfileURL: 'https://in.linkedin.com/in/dummy-link-775982111?original_referer=https%3A%2F%2Fwww.google.com%2F04'
        
        },
        
        {
        
        id: 6,
        
        subtitle: 'This masterpiece is renowned for its swirling, turbulent. Making this the first true generator on the Internet.',
        
        imageURL: 'https://imageio.forbes.com/specials-images/imageserve/61688aa1d4a8658c3f4d8640/Antonio-Juliano/0x0.jpg?format=jpg&width=960',
        
        fbLogoURL: 'https://ww2.freelogovectors.net/wp-content/uploads/2023/03/facebook-logo-new-2019-freelogovectors.net_.png',
        
        fbProfileURL: 'https://www.facebook.com/profile.php?=1000000982382774',
        
        linkedinLogoURL: 'https://i.pinimg.com/1200x/cd/3e/d5/cd3ed5a95ef5ac1d694899a51798874b.jpg',
        
        linkedinProfileURL: 'https://in.linkedin.com/in/dummy-link-775982111?original_referer=https%3A%2F%2Fwww.google.com%2F04'
        
        }
        
        ]
        
        
        handleFB(event){
        let id = event.currentTarget.dataset.id;
        let cardItem = this.card.find(element=>{
        return (element.id==id);
        })
        window.open(cardItem.fbProfileURL)
        }
        
        
        handleLinkedIn(event){
        let id = event.currentTarget.dataset.id;
        let cardItem = this.card.find(element=>{
        return (element.id==id);
        })
        window.open(cardItem.linkedinProfileURL)
        }
 }