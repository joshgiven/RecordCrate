package data;

//import static junit.framework.TestCase.fail;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;


public class DaoTests {
	InventoryDAO dao;

	@Before
	public void setUp() {
		//String fileName = "/Users/josh/SD/Java/stsworkspace/Inventory/test/data/testdata.txt";
		//dao = new InventoryDaoJsonImpl(fileName);
		dao = new InventoryDaoJsonImpl();
	}
	
	@After
	public void tearDown(){
		dao = null;
	}

	void addSomeArtistsToDao() {
		
	}
	
	@Test
	public void test_DAO_getAllArtists_returns_sorted_list() {
		Artist fz = new Artist();
		fz.setName("Frank Zappa");
		fz.setSortName("Zappa, Frank");
		
		Artist mogwai = new Artist();
		mogwai.setName("Mogwai");
		mogwai.setSortName("Mogwai");
		
		Artist eno = new Artist();
		eno.setName("Brian Eno");
		eno.setSortName("Eno, Brian");
		
		dao.updateArtist(fz);
		dao.updateArtist(mogwai);
		dao.updateArtist(eno);
		
		List<Artist> allArtists = dao.getAllArtists();
		assertEquals("Brian Eno",   allArtists.get(0).getName());
		assertEquals("Mogwai",      allArtists.get(1).getName());
		assertEquals("Frank Zappa", allArtists.get(2).getName());
	}
	
	@Test
	public void test_DAO_getAllAlbums_returns_sorted_list() {
		Artist fz = new Artist();
		fz.setName("Frank Zappa");
		fz.setSortName("Zappa, Frank");
		
		Artist mogwai = new Artist();
		mogwai.setName("Mogwai");
		mogwai.setSortName("Mogwai");
		
		Artist eno = new Artist();
		eno.setName("Brian Eno");
		eno.setSortName("Eno, Brian");
		
		dao.updateArtist(fz);
		dao.updateArtist(mogwai);
		dao.updateArtist(eno);
		
		Album jets = new Album();
		jets.setTitle("Here Come the Warm Jets");
		jets.setYear(1973);
		jets.setArtist(eno);
		
		Album hawk = new Album();
		hawk.setTitle("The Hawk Is Howling");
		hawk.setYear(2008);
		hawk.setArtist(mogwai);
		
		Album yawyi = new Album();
		yawyi.setTitle("You Are What You Is");
		yawyi.setYear(1981);
		yawyi.setArtist(fz);
		
		dao.updateAlbum(yawyi);
		dao.updateAlbum(jets);
		dao.updateAlbum(hawk);
		
		List<Album> allAlbums = dao.getAllAlbums();
		assertEquals("Brian Eno",               allAlbums.get(0).getArtist().getName());
		assertEquals("Here Come the Warm Jets", allAlbums.get(0).getTitle());
		assertEquals("Mogwai",                  allAlbums.get(1).getArtist().getName());
		assertEquals("The Hawk Is Howling",     allAlbums.get(1).getTitle());
		assertEquals("Frank Zappa",             allAlbums.get(2).getArtist().getName());
		assertEquals("You Are What You Is",     allAlbums.get(2).getTitle());
	}
	
//		try {
//			MvcResult result = mockMvc.perform(get("/GetStateData.do").param("name", "Colorado"))
//					.andExpect(status().isOk()).andReturn();
//			
//			ModelAndView mv = result.getModelAndView();
//			//assertEquals("result.jsp", mv.getViewName());
//			assertEquals("result", mv.getViewName());
//			ModelMap map = mv.getModelMap();
//			assertNotNull(map.get("state"));
//
//			// From MockStateDAO :
//			// states.add(new State("MI", "Michigan", "Lansing", "1.0", "2.0"));
//			// states.add(new State("CO", "Colorado", "Denver", "3", "4"));
//
//			State st = (State) map.get("state");
//			assertEquals("Colorado", st.getName());
//			assertEquals("CO", st.getAbbreviation());
//			assertEquals("3", st.getLatitude());
//			// TODO - test other fields
//			assertEquals("Denver", st.getCapital());
//			assertEquals("4", st.getLongitude());
//			assertEquals("8888", st.getCapitalPopulation());
//
//
//		} catch (Exception e) {
//			fail(e.toString());
//		}
//	}
//
//	@Test
//	public void test_GET_GetStateData_do_with_invalid_name_param_returns_null() {
//		try {
//			MvcResult result = mockMvc.perform(get("/GetStateData.do").param("name", "Kolorado"))
//					.andExpect(status().isOk()).andReturn();
//			
//			ModelAndView mv = result.getModelAndView();
//			//assertEquals("result.jsp", mv.getViewName());
//			assertEquals("result", mv.getViewName());
//			ModelMap map = mv.getModelMap();
//
//			assertNull(map.get("state"));
//		} 
//		catch (Exception e) {
//			e.printStackTrace();
//
//			fail(e.toString());
//		}
//
//	}
//
//	@Test
//	public void test_GET_GetStateData_do_with_valid_abbr_param_returns_State() {
//		// TODO - complete this
//		try {
//			MvcResult result = mockMvc.perform(get("/GetStateData.do").param("abbr", "CO"))
//					.andExpect(status().isOk()).andReturn();
//			
//			ModelAndView mv = result.getModelAndView();
//			//assertEquals("result.jsp", mv.getViewName());
//			assertEquals("result", mv.getViewName());
//
//			ModelMap map = mv.getModelMap();
//			assertNotNull(map.get("state"));
//
//			State st = (State) map.get("state");
//			assertEquals("Colorado", st.getName());
//			assertEquals("CO", st.getAbbreviation());
//			assertEquals("3", st.getLatitude());
//			assertEquals("Denver", st.getCapital());
//			assertEquals("4", st.getLongitude());
//			assertEquals("8888", st.getCapitalPopulation());
//
//		} 
//		catch (Exception e) {
//			fail(e.toString());
//		}
//
//	}
//
//	@Test
//	public void test_GET_GetStateData_do_with_invalid_abbr_param_returns_null() {
//		// TODO - complete this
//		try {
//			MvcResult result = mockMvc.perform(get("/GetStateData.do").param("name", "KO"))
//					.andExpect(status().isOk()).andReturn();
//			
//			ModelAndView mv = result.getModelAndView();
//			//assertEquals("result.jsp", mv.getViewName());
//			assertEquals("result", mv.getViewName());
//			ModelMap map = mv.getModelMap();
//
//			assertNull(map.get("state"));
//
//		} 
//		catch (Exception e) {
//			fail(e.toString());
//		}
//
//	}
//
//	@Test
//	public void test_POST_NewState_do_adds_state() {
//		// TODO - complete this
//		// check the mock object's list directly
//		
//		try {
//			String abbreviation = "KS";
//			String name = "Kansas";
//			String capital = "Lawrence";
//			String latitude = "69";
//			String longitude = "42";
//			String capitalPopulation = "8";
//			
//			//State testState =  new State(abbreviation, name, capital, latitude, longitude);
//				 
//			
//			MvcResult result = 
//					mockMvc.perform(
//						post("/NewState.do")
//						.param("abbreviation", abbreviation)
//						.param("name", name)
//						.param("capital", capital)
//						.param("latitude", latitude)
//						.param("longitude", longitude)
//						.param("capitalPopulation", capitalPopulation))
//					.andExpect(status().isOk()).andReturn();
//			
//			ModelAndView mv = result.getModelAndView();
//			//assertEquals("result.jsp", mv.getViewName());
//			assertEquals("result", mv.getViewName());
//
//			State resultState = mockDAO.getStateByName(name);
//			assertNotNull(resultState);
//			
//			assertEquals(abbreviation, resultState.getAbbreviation());
//			assertEquals(name,         resultState.getName());
//			assertEquals(capital,      resultState.getCapital());
//			assertEquals(latitude,     resultState.getLatitude());
//			assertEquals(longitude,    resultState.getLongitude());
//			assertEquals(capitalPopulation, resultState.getCapitalPopulation());
//
//		} 
//		catch (Exception e) {
//			e.printStackTrace();
//
//			fail(e.toString());
//		}
//	}
}
