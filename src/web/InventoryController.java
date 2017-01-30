package web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import data.Album;
import data.Artist;
import data.InventoryDAO;

@Controller
public class InventoryController {

	@Autowired
	private InventoryDAO dao;
	
	@RequestMapping(path="index.do", method=RequestMethod.GET)
	public ModelAndView displayIndex() {
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("albums", dao.getAllAlbums());
		mv.addObject("artists", dao.getAllArtists());
		
		mv.setViewName("index");
		return mv;
	}
	
	@ModelAttribute("newArtist")
	Artist newArtist() {
		return new Artist();
	}
	
	@RequestMapping(path="createArtistForm.do", method=RequestMethod.GET)
	public ModelAndView createArtistForm() {
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("artists", dao.getAllArtists());
		mv.setViewName("artistForm");
		
		return mv;
	}

	@RequestMapping(path="createArtist.do", method=RequestMethod.POST)
	public ModelAndView createArtist(
			@ModelAttribute("newArtist") Artist newArtist ) {
		
		dao.updateArtist(newArtist);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("artist", newArtist);
		mv.addObject("albums", dao.getAlbumsByArtist(newArtist));
		
		mv.setViewName("displayArtist");
		return mv;
	}

	@RequestMapping(path="displayArtist.do", method=RequestMethod.GET)
	public ModelAndView displayArtist(
			@RequestParam Integer id ) {
		ModelAndView mv = new ModelAndView();
		
		Artist artist = dao.getArtistById(id);
		mv.addObject("artist", artist);
		mv.addObject("albums", dao.getAlbumsByArtist(artist));
		
		mv.setViewName("displayArtist");
		return mv;
	}

	@RequestMapping(path="updateArtistForm.do", method=RequestMethod.GET)
	public ModelAndView updateArtistForm( @RequestParam Integer id ) {
		
		Artist theArtist = dao.getArtistById(id);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("update", true);
		mv.addObject("theArtist", theArtist);
		
		mv.setViewName("artistForm");
		return mv;

	}
	
	@RequestMapping(path="destroyArtist.do", method=RequestMethod.POST)
	public ModelAndView destroyArtist( @RequestParam Integer id ) {
		Artist theArtist = dao.getArtistById(id);
		dao.destroyArtist(theArtist);
		
		return displayIndex();
	}
	
	@ModelAttribute("newAlbum") 
	Album newAlbum() {
		return new Album();
	}
	
	@RequestMapping(path="createAlbumForm.do", method=RequestMethod.GET)
	public ModelAndView albumForm() {
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("artists", dao.getAllArtists());
		mv.setViewName("albumForm");

		return mv;
	}

	@RequestMapping(path="createAlbum.do", method=RequestMethod.POST)
	public ModelAndView createAlbum(
			@RequestParam("artistId") int artistId,
			@ModelAttribute("newAlbum") Album newAlbum ) {
		
		Artist artist = dao.getArtistById(artistId);
		newAlbum.setArtist(artist);
		
		dao.updateAlbum(newAlbum);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("album", newAlbum);

		mv.setViewName("displayAlbum");
		return mv;
	}

	@RequestMapping(path="displayAlbum.do", method=RequestMethod.GET)
	public ModelAndView displayAlbum( @RequestParam Integer id ) {
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("album", dao.getAlbumById(id));
		mv.setViewName("displayAlbum");
		return mv;
	}
	
	@RequestMapping(path="updateAlbumForm.do", method=RequestMethod.GET)
	public ModelAndView updateAlbumForm( @RequestParam Integer id ) {
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("update", true);
		mv.addObject("artists", dao.getAllArtists());
		mv.addObject("theAlbum", dao.getAlbumById(id));
		mv.setViewName("albumForm");

		return mv;
	}
	
	@RequestMapping(path="destroyAlbum.do", method=RequestMethod.POST)
	public ModelAndView destroyAlbum( @RequestParam Integer id ) {
		Album album = dao.getAlbumById(id);
		dao.destroyAlbum(album);
		
		return displayIndex();
	}

}
