package enginee.processing.query;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import socet.GetClientQuery;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/")
public class MainController {
	@Autowired
	private ClientManager clientManager;
    @Autowired
    private PhotoManager photoManager;

    private MoneyList moneyList=new MoneyList();
    private DeliveryList deliveryList=new DeliveryList();

    @RequestMapping(value = "/form_add_client", method = RequestMethod.GET)
    public String formClient() {
        return "form_add_client";
    }////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping(value = "/add_client", method = RequestMethod.POST)
    public String addClient(
       @RequestParam(value="login") String login,
        @RequestParam(value="password") String password,
        @RequestParam(value="inner") String inner){
        Client client=new Client(login, password, inner);
        clientManager.addClient(client);
        return "form_add_client";
    }////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping(value = "/form_add_image", method = RequestMethod.GET)
    public String FormImage(){
        return "form_add_image";
    }////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping(value = "/add_image", method = RequestMethod.POST)
    public String addImage(
            @RequestParam(value = "name") String name,
            @RequestParam(value = "photo") MultipartFile file,
            HttpServletRequest request,
            HttpServletResponse response) {
        try {
            Photo photo=new Photo(name.isEmpty()? file.getOriginalFilename().toLowerCase() : name, file.getBytes());
            photoManager.addPhoto(photo);
            return "form_add_image";
        } catch (IOException ex) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return null;
        }
    }////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping("/image/{file_name}")
    public void getImage(HttpServletRequest reguest, HttpServletResponse respon,

                         @PathVariable("file_name") String image) {
        try {
            byte[] photo = photoManager.getPhoto(image+".png");
            respon.setContentType("image/png");
            respon.getOutputStream().write(photo);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping("/")
	public String registration() {
	    return "registration";
    }
    @RequestMapping(value = "/mainWindow", method = RequestMethod.GET)
    public String main(Model model, HttpServletRequest request, HttpServletResponse respons) {
        String direct="";
        if (getSessionClient(request.getCookies()) != null){
            direct="mainWindow";
        }return direct;
    }////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping(value = "/controlUserSession", method = RequestMethod.POST)
    public void controlUserSession(
            HttpServletResponse response,
            @RequestParam(value="login") String login,
            @RequestParam(value="password") String password){
        if (getClient(login,password)!=null ){
            response.addCookie(new Cookie("login", login));
            response.addCookie(new Cookie("password", password));
            return;
        }try {
            response.getOutputStream().write("negative".getBytes());
        }catch (IOException e) {
            e.printStackTrace();
        }
    }////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping(value = "/analis/{form_name}", method = RequestMethod.GET)
    public String analis(Model model, HttpServletRequest request, HttpServletResponse respons,
    @PathVariable("form_name" ) String form ) {
        String redirec = "registration";
        if (getSessionClient(request.getCookies()) != null) {
            redirec= form;
        }return redirec;
    }////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping(value = "/goods/{list_id}", method = RequestMethod.POST)
    public ModelAndView getParentList(Model model,
    @PathVariable(value = "list_id") String list_id,
    @RequestParam(value = "id") String id ){
        String form; String method; String[] param;
        if (list_id.equals("category")){
            form="GoodsReport"; method="goodsCategList"; param=new String[]{null};
        }else if (list_id.equals("group")){
            form="GoodsReport"; method="goodsGroupList"; param=new String[]{id, null};
        }else {
            form="Report"; method="carencyList"; param=new String[]{};}
        GetClientQuery getClientQuery=new GetClientQuery(
                new Client(),
                new Client_Query(form, method, param));
        ModelAndView modelAndView=new  ModelAndView("list");
        modelAndView.addObject("scope", getClientQuery.getResult());
        return modelAndView;
    }////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping(value = "/stock", method = RequestMethod.POST)
    public ModelAndView orderList(HttpServletRequest request, HttpServletResponse response,
    @RequestParam(value="gr_id") String gr_id,
    @RequestParam(value="cs_id") String cs_id){
        Client client=getSessionClient(request.getCookies());
        if (client==null){return null;}
        String cource=moneyList.getCource(cs_id);
        GetClientQuery getClientQuery=new GetClientQuery(
                client,
                new Client_Query("GoodsReport","packGoodsList", new String[]{
                gr_id,  client.getNum(), "-1",  cource, "true", "4","3", "0"}));
        int id=0;
        List list=getClientQuery.getResult();
        for (String[] st : (List<String[]>) getClientQuery.getResult()){
            /* if (st[8].isEmpty()){continue;} */
            String[] res={String.valueOf(id+1), st[0], st[1],  st[2], st[6], st[8]};
            list.set(id++, res);
        }return new ModelAndView("table", "scope", list);
    }////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping(value = "advance/{file_id}", method = RequestMethod.GET)
    public void advance(HttpServletResponse response,
    @PathVariable("file_id") String path) {
        GetClientQuery getClientQuery=new GetClientQuery(
                new Client(),
                new Client_Query("PropertyEditor","getAltEditData", new String[]{path, "1"}));
        try {
            OutputStream outputStream=response.getOutputStream();
            byte[] photo=null;
            if((photo=photoManager.getPhoto(path+".jpg"))!=null ){


                response.setContentType("image/jpeg");
                outputStream.write(photoManager.getPhoto(path+".jpg")); return;
            }
            response.getOutputStream().write(((String[])(getClientQuery.getResult().get(0)))[0].getBytes("UTF-8"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @RequestMapping(value = "/sendBasket", method = RequestMethod.POST)
    public void addConsist(HttpServletRequest request, HttpServletResponse response,
    @RequestParam(value = "orderArray")  String[] src){
        Client client=getSessionClient(request.getCookies());
        if (client==null){return;}
        ArrayList<String[]>res=new ArrayList<String[]>();
        res.add(new String[]{client.getNum(), src[0], "", "", "", "", "", "", "", "", "", "", ""});
        for(int i=1; i<src.length; i+=3){
            res.add(new String[]{src[i], src[i + 1]});
        }
        GetClientQuery getClientQuery=new GetClientQuery(
                client,
                new Client_Query("DeliberateAction","addOutsideOrder", res));
        try {
            response.getOutputStream().write(((ArrayList<String[]>)getClientQuery.getResult()).get(0)[0].getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @RequestMapping(value = "/registrationOrder", method = RequestMethod.POST)
    public void  registrationOrder(HttpServletRequest request, HttpServletResponse response,
    @RequestParam(value = "index") String index,
    @RequestParam(value = "customer") String customer,
    @RequestParam(value = "receiver")  String receiver,
    @RequestParam(value = "phone")  String phone,
    @RequestParam(value = "sheepedCompany")  String sheepedCompany,
    @RequestParam(value = "comment")  String comment,
    @RequestParam(value = "warrantName")  String warrantName,
    @RequestParam(value = "warrantNumb")  String warrantNumb,
    @RequestParam(value = "warrantDate")  String warrantDate){
        try {
            String rightString= new String(customer.getBytes("utf-8"),  "windows-1251");
            System.out.println("rightString="+rightString);
        } catch (UnsupportedEncodingException e){
            e.printStackTrace();
        }
        if(index.matches("[A-Z]{4}-[0-9]{3}")){
            String[] info = new String[]{index, customer, "", phone, receiver, "", "",
                    comment, sheepedCompany, "", "", "", warrantName, warrantNumb, warrantDate};
            GetClientQuery getClientQuery = new GetClientQuery(
                    new Client(),
                    new Client_Query("General", "putExtendFinNote", info));
        }
        try {
            response.sendRedirect("/thanks");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @RequestMapping(value = "/infoBox", method = RequestMethod.POST)
    public void getInfoBox(HttpServletResponse response,
    @RequestParam(value = "stamp") String stamp){
        GetClientQuery getClientQuery = new GetClientQuery(
                new Client(),
                new Client_Query("General", "getExtendFinNote", new String[]{stamp}));
        try {
//            String[] info = new String[]{index, customer, "", phone, receiver, "", "",
//                    comment, sheepedCompany, "", "", "", warrantName, warrantNumb, warrantDate};
            /*****************************Adapter***************************************/
            String[] src=((ArrayList<String[]>)getClientQuery.getResult()).get(0);
            System.out.println(src.length);
            String[] val=new String[]{src[0], src[3], src[2], src[7], src[6], src[11], src[12],  src[13]};
            Gson gson=new GsonBuilder().create();
            String json= gson.toJson(val);
            response.getOutputStream().write(json.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    @RequestMapping(value = "/thanks", method = RequestMethod.GET)
    public String thanksForm(){
        return "thanks";
    }
    @RequestMapping(value = "/ordersClient", method = RequestMethod.GET)
    public ModelAndView getOrdersClient(HttpServletRequest request){
        Client client=getSessionClient(request.getCookies());
        if (client==null){return null;}
        GetClientQuery getClientQuery = new GetClientQuery(
                client,
                new Client_Query("GoodsReport", "clientsOrderList", new String[]{client.getNum()}));
        ArrayList<String[]>result=(ArrayList<String[]>) getClientQuery.getResult();
        for(String[] st : result){st[5]=moneyList.getShortName(st[5]);
        }ModelAndView modelAndView=new  ModelAndView("stamp_list");
        modelAndView.addObject("scope", result);
        return modelAndView;
    }
    @RequestMapping(value = "/consistOrder")
    public ModelAndView getConsistOrder(HttpServletRequest request,
    @RequestParam(value = "stamp")  String stamp){
        GetClientQuery getClientQuery = new GetClientQuery(
                new Client(),
                new Client_Query("GoodsReport", "getTradeRecord", new String[]{stamp}));
        ModelAndView modelAndView=new  ModelAndView("adjustment_list");
        modelAndView.addObject("scope", getClientQuery.getResult());
        return modelAndView;
    }
    @RequestMapping(value = "/statusOrder", method = RequestMethod.POST)
    public void getStatusOrder(HttpServletRequest request,
    HttpServletResponse response,
    @RequestParam(value = "stamp")  String stamp){
        Client client=getSessionClient(request.getCookies());
        if (client==null){return;}
        GetClientQuery getClientQuery = new GetClientQuery(
                client,
                new Client_Query("General", "getMonitorStatus", new String[]{stamp}));
        try {
            response.getOutputStream().write( ( (ArrayList<String[]>) getClientQuery.getResult()).get(0)[0].getBytes() );
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    private Client getSessionClient(Cookie[] cookie){
        if(cookie.length<2){return null;}
        String login=cookie[0].getValue();
        String password=cookie[1].getValue();
        return getClient(login, password);
    }
    private Client getClient(String login, String password){
        Client client=clientManager.getClient(login);
        if(client==null){return null;}
        if(!client.isAccess(password)){return null;}
        return client;
    }
//    @RequestMapping(value = "/monitor")
//    public ModelAndView getMonitorStatus(HttpServletRequest request){
//        Client client=getSessionClient(request.getCookies());
//        if (client==null){return new ModelAndView("registration");}
//        GetClientQuery getClientQuery=new GetClientQuery(
//                client,
//                new Client_Query("GoodsReport","clientsOrderList", new String[]{client.getId()}));
//        List list=getClientQuery.getResult();
//        return new ModelAndView("rest", "scope", getClientQuery.getResult());
//    }
//    @RequestMapping(value = "/order")
//    public String orderGoods(HttpServletRequest request) {
//        return "order";
//    }
//    @RequestMapping(value = "/rest")
//    public ModelAndView getRestGoods(HttpServletRequest request) {
//        Client client=getSessionClient(request.getCookies());
//        if (client==null){return new ModelAndView("registration");}
//        GetClientQuery getClientQuery=new GetClientQuery(
//                client,
//                new Client_Query("GoodsReport","shopItemList", new String[]{""}));
//        return new ModelAndView("rest", "scope", getClientQuery.getResult());
//    }

}