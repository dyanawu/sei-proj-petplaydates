# pawdates - simple, friendly pet events and meetups

## Technologies & Libraries
- Ruby on Rails (6.0.3)
- PostgreSQL
- [Faker](https://github.com/faker-ruby/faker.git)
- [Owl Carousel](https://github.com/OwlCarousel2/OwlCarousel2)
- [Simple Calendar](https://github.com/excid3/simple_calendar)
- [Cloudinary](https://cloudinary.com/)
- [Google Places API](https://developers.google.com/places/web-service/intro)

## Approach
First, we discussed basic features and collaborated on an ERD/wireframe, then implemented a simple version of the app with unstyled information on each page. As we worked deeper into the domain, we iterated towards the final format and design.

## Install
Fork repo, then:
```
git clone https://github.com/<you>/sei-proj-petplaydates
cd sei-proj-playdates
bundle install
rails db:create
rails db:schema:load
rails db:seed
```
To run:
```
rails s
```
Then navigate to:
http://localhost:3000

## Design artifacts
[ERD](https://github.com/dyanawu/sei-proj-petplaydates/blob/master/docs/pawdates_erd.png)

[Wireframe](https://github.com/dyanawu/sei-proj-petplaydates/blob/master/docs/pawdates_wireframe.pdf)

## Unsolved problems
- Fully responsive design
