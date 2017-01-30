![alt text][crate]


# RecordCrate aka RecordBin

Skill Distillery SD8 - Week 8 (1/25/2017)

SpringMVC CRUD WebApp

Josh Given (josh.given@gmail.com)

### Project Description
RecordCrate (dba RecordBin) is an album-centric music tracking system.

### Technologies Used
- Java
  - Annotation-Driven SpringMVC
  - Jackson JSON persistence
- CSS-styled JSP/HTML
  - JSTL
- Ruby
  - JSON library
- Tomcat8
- Amazon Web Services EC2
- Eclipse
    - Spring Tool Suite
- Git
  - Github
- Web Services
  - MusicBrainz
  - Cover Art Archive

### Implementation

#### Java Classes
- InventoryController
- InventoryDAO - Data Access Object for Artist/Album data
  - JSON-backed Implementation
- Beans
  - Artist - POJO abstraction of a musician/band/ensemble
  - Album - POJO abstraction of a record/CD/8-track release
  - Track - POJO representing a song/track on an Album

#### JSP
- index - displays galleries of Albums, Artists
- displayAlbum - shows details about an Album
- displayArtist - shows details about an Artist
- createAlbum - create/update/delete an Album
- createArtist - create/update/delete an Artist

### Future Features/Modifications
- Use Spring Validation for form input
- Implement MusicBrainz queries in Java and incorporate
  that functionality into web app
- Image lookup/download for Artist images
- Modularize the Controller by functionality
  (Read/Display, Create/Update/Delete)
- Implement a hierarchical set of Genre classes
- add searchsorting features - by genre, by date, by track, etc

### Stumbles & Bumbles
- Time-Management - Too much time spent on gathering images/data via MusicBrainz
- CSS - Need to study CSS quite a bit

![alt text][crate]

[crate]: ./WebContent/img/full_record_crate.jpg "Logo Title Text 2"
