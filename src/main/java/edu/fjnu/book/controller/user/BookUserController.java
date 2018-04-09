package edu.fjnu.book.controller.user;

import java.net.InetAddress;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;

import edu.fjnu.book.controller.BaseController;
import edu.fjnu.book.domain.HomePage;
import edu.fjnu.book.domain.MsgItem;
import edu.fjnu.book.domain.Sysconfig;
import edu.fjnu.book.domain.User;
import edu.fjnu.book.service.HomePageService;
import edu.fjnu.book.service.SysconfigService;
import edu.fjnu.book.service.UserService;
import edu.fjnu.book.util.MailUtils;

/**
 * 前台用户Controller
 * @author hspcadmin
 *
 */
@Controller
public class BookUserController extends BaseController {
	@Autowired
	UserService userService;
	@Autowired
	SysconfigService sysconfigService;
	@Autowired
	HomePageService homePageService;
	//跳转到登录页面
	@RequestMapping("/user/login.action")
	public String toLoinPage(User user, Model model, HttpSession session){
		return "/user/login.jsp";			
	}
	
	//跳转到登录页面
	@RequestMapping("/user/toRegistPage.action")
	public String toUserRegistPage(User user, Model model, HttpSession session){
		return "/user/regist.jsp";			
	}
	
	/**
	 * 跳转到登录页面
	 * @param user
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("/user/toIndex.action")
	public String toIndex(User user, Model model, HttpSession session){
		PageInfo<HomePage> pageInfo = homePageService.findByPage(new HomePage(), 1, 1000);
		List<HomePage> dataList = pageInfo.getList();
		model.addAttribute("dataList", dataList);
		model.addAttribute("pageInfo", pageInfo);
		if(session.getAttribute("userName")!= null){
			return "/user/index.jsp";
		}else{
			return "forward:/user/login.action";
		}
	}
	
	/**
	 * 用户登录
	 * @param user
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("/user/checkUserPwd.action")
	@ResponseBody
	public MsgItem checkUserPwd(User user, Model model, HttpSession session){
		MsgItem item = new MsgItem();
		User loginUser = userService.login(user);
		if(loginUser!=null && "1".equals(loginUser.getUserType())){
			if("1".equals(loginUser.getUserState())){
				item.setErrorNo("1");
				item.setErrorInfo("该账号尚未激活!");
			}else{
				item.setErrorNo("0");
				item.setErrorInfo("登录成功!");
				session.setAttribute("userName", loginUser.getUserName());
				session.setAttribute("user", loginUser);
			}
		}else{
			item.setErrorNo("2");
			item.setErrorInfo("账号不存在或用户名密码错误!");
		}
		return item;
	}
	
	/**
	 * 用户注册
	 * @param user
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("/user/regist.action")
	@ResponseBody
	public MsgItem userRegist(User user, Model model, ServletRequest servletRequest){
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		MsgItem item = new MsgItem();
		user.setUserState("1");
		user.setUserType("1");
		try {
			
			item.setErrorNo("0");
			item.setErrorInfo("注册成功!");
			Sysconfig conf = sysconfigService.getByName("ADMIN_EMAIL_ACCOUNT");
			Sysconfig conf1 = sysconfigService.getByName("ADMIN_EMAIL_PWD");
			if(conf!=null && conf1 !=null){
				String path = request.getContextPath(); 
				InetAddress addr = InetAddress.getLocalHost();  
		        String ip=addr.getHostAddress().toString(); //获取本机ip  
            	String repUrl = request.getScheme()+"://"+ip
            			+":"+request.getServerPort()+path+"/user/activeUser.action?userId="+user.getUserId()+"&dt="+new Date();
				MailUtils.sendMail(conf.getParamValue(), conf1.getParamValue(), user.getEmail(), "这是一封来自图书网的激活邮件，请点击下面超链接进行激活</br>"+repUrl);
				item.setErrorNo("0");
				item.setErrorInfo("注册成功，请登录邮箱激活!");
				userService.insert(user);
			}else{
				item.setErrorNo("1");
				item.setErrorInfo("发送失败!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			item.setErrorNo("0");
			item.setErrorInfo("注册失败!");
		}
		return item;
	}
	
	/**
	 * 用户激活
	 * @param user
	 * @param model
	 * @param servletRequest
	 * @return
	 */
	@RequestMapping("/user/activeUser.action")
	public String activeUser(User user, Model model, ServletRequest servletRequest){
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		String uri = request.getRequestURI();
		System.out.println(uri);
		if(user != null){
			user.setUserState("2");
			userService.update(user);
			User activeUser = userService.get(user.getUserId());
			request.getSession().setAttribute("userName", activeUser);
		}
		return "/user/index.jsp";
	}
}
