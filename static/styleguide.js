document.addEventListener('DOMContentLoaded', function() {
    // smooth scroll to anchors
    document.querySelectorAll("#main-nav a").forEach( a => {
        a.addEventListener('click', function(evn){
            evn.preventDefault();
            document.getElementById(a.hash.replace('#','')).scrollIntoView({behavior: 'smooth'})
            // change location hash after smooth scrolling
            setTimeout(() => window.location.hash = a.hash, 1000)
        })
    });

    // use intersection observer to detect section

    // detect element on the top portion
    let options = {
        rootMargin: '-10% 0px -89% 0px'
    }

    // set current element nav class
    let callback = (entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                document.querySelectorAll('#main-nav a').forEach( a => { a.classList.remove('nav-active') })
                document.querySelector('[href="#' + entry.target.id + '"]').classList.add('nav-active')    
            }
        });
    };

    // create observer
    let observer = new IntersectionObserver(callback, options);

    // observe all elements
    document.querySelectorAll('#sections > div').forEach(section => {
        observer.observe(section)
    })

    // prevent links default behavior
    document.querySelectorAll('a').forEach( a => {
        a.addEventListener('click', function(event) { event.preventDefault(); })
    });

    document.getElementById("nav-button").addEventListener('click', function() {
        document.getElementById('main-nav').classList.toggle('open')
        document.getElementById('nav-button').classList.toggle('open');
        document.body.classList.toggle('modal-active');
    });

    document.querySelectorAll('#main-nav a').forEach( a => {
        a.addEventListener('click', function() {
            document.getElementById('main-nav').classList.remove('open')
            document.getElementById('nav-button').classList.remove('open');
            document.body.classList.remove('modal-active');
        })
    })
});
