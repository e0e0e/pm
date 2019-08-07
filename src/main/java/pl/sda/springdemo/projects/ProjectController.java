package pl.sda.springdemo.projects;


import org.apache.logging.log4j.util.PropertySource;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pl.sda.springdemo.sprint.Sprint;
import pl.sda.springdemo.task.Task;
import pl.sda.springdemo.users.User;
import pl.sda.springdemo.users.UserService;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.Period;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class ProjectController {
    private final UserService userService;
    private final ProjectService projectService;


    public ProjectController(UserService userService, ProjectService projectService) {
        this.userService = userService;
        this.projectService = projectService;
    }

    @GetMapping("/project")
    public String ShowProjectForm(HttpServletRequest request,
                                  Model model) {

        //request.getSession().setAttribute("username",);
        String loggedUser = request.getRemoteUser();
        System.out.println("you are logged as: " + loggedUser);
        model.addAttribute("users", userService.findAll());
        model.addAttribute("loggedUser", loggedUser);
//        List<String> sessionVals = Collections.list(request.getSession().getAttributeNames());
//
//        sessionVals.stream().forEach(s -> System.out.println(s));
//        Object spring_security_context = request.getSession().getAttribute("SPRING_SECURITY_CONTEXT");
//        System.out.println(spring_security_context);

        model.addAttribute("title", "Add Project");
        model.addAttribute("path", "project/project");

        return "main";
    }

    @PostMapping("/project")
    public String addProject(@RequestParam String projectName,
                             @RequestParam String description,
                             @RequestParam Long user,
                             Model model) {


        // model.addAttribute("loggedUser", userService.getLogged());


        try {

            //dodanie usera
            boolean result = projectService.create(projectName, description, userService.findById(user));


            model.addAttribute("createProjectResult", result);
            List<Project> projects = projectService.findAll();


//            userService.findById(user).setProjectsParticipants(projects);

            model.addAttribute("projects", projects);

            //System.out.println(email + " " + password + " " + datfB);
            return "project/projectList";
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getLocalizedMessage());

            return "user/project";
        }
//
//
//        System.out.println(projectName + " | " + description + " | " + user);
//        return "users/project";
    }

    @GetMapping("users/projectList")
    public String listProjects(Model model) {

        List<Project> projects = projectService.findAll();

//        System.out.println(projectList.size());
        model.addAttribute("projects", projects);
        model.addAttribute("loggedUser", userService.getLogged());
        return "project/projectList";
    }

    @GetMapping("project/delete")
    public String deleteProject(@RequestParam long projectId,
                                Model model) {

        projectService.delete(projectId);
        model.addAttribute("projects", projectService.findAll());
        model.addAttribute("deleteProjectResults", true);
        model.addAttribute("loggedUser", userService.getLogged());

        return "project/projectList";

    }

    @GetMapping("/participant")
    public String addParticipant(@RequestParam long projectId,
                                 Model model) {

        model.addAttribute("projects", projectService.findById(projectId).get());
        model.addAttribute("users", userService.findAll());/**/
        model.addAttribute("loggedUser", userService.getLogged());
        return "participant/participants";
    }

    @PostMapping(value = "project/participant", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String addParticipantToProject(@RequestParam long projectId,
                                          @RequestParam long userId,
                                          Model model) {

        // model.addAttribute("addingToProjectID",projectService.findById(projectId));
        User user = userService.findById(userId);
        Project project = projectService.findById(projectId).get();
        user.getProjectsParticipants().add(project);
        project.getUsers().add(user);
        userService.save(user);

        model.addAttribute("projects", projectService.findAll());
        model.addAttribute("users", projectService.getUsers(projectId));
        model.addAttribute("loggedUser", userService.getLogged());
        return "project/projectList";
    }

    @GetMapping("login")
    public String login() {

        return "user/login";
    }

//    @GetMapping("/")
//    public String start(@CookieValue(value = "userName", defaultValue = "") String userName,
//                        @CookieValue(value = "password", defaultValue = "") String password,
//                        Model model) {
//
//
//        if (userService.getLogged() == null) {
//         userService.login(userName, password);
////            System.out.println(cookies.);
//            model.addAttribute("loggedUser", userService.getLogged());
//            model.addAttribute("users", userService.findAll());
//            return "users/list";
//        } else {
//            return "project/projectList";
//        }
//    }
//
//    @PostMapping("login")
//    public String loginUser(@RequestParam String userName,
//                            @RequestParam String password,
//                            HttpServletResponse response,
//                            Model model) {
//
//        userService.login(userName, password);
//        Cookie cookie=new Cookie("userName", userName);
//        Cookie cookie2=new Cookie("password", password);
//        response.addCookie(cookie);
//        response.addCookie(cookie2);
//
//        model.addAttribute("loggedUser", userService.getLogged());
//        model.addAttribute("users", userService.findAll());
//        return "user/list";
//    }

    @GetMapping("logout")
    public String logoutUser(Model model,
                             HttpServletRequest request,
                             HttpServletResponse response) {
        userService.logout();

        return "user/login";
    }

    @GetMapping("/project/show")
    public String showProject(@RequestParam Long projectId,
                              Model model) {
        Project project = projectService.findById(projectId).get();

        List<Integer> numberOfDeys = project.getTask().stream().map(e ->
                Math.abs(Period.between(e.getSprint().getStartDate(), e.getSprint().getFinishDate()).getDays()))
                .collect(Collectors.toList());

                project.getTask().stream()
                        .collect(Collectors.toMap(x->x.getId(),x->x.getSprint().getStartDate()));
        LocalDate maxFinishDate = project.getTask().stream().max(Comparator.comparing(e -> e.getSprint().getFinishDate())).get().getSprint().getFinishDate();
        LocalDate minStartDate = project.getTask().stream().min(Comparator.comparing(e -> e.getSprint().getStartDate())).get().getSprint().getStartDate();
//        timeTable(minStartDate,start,finish,fromStartToFinish)

        // project.getTask().stream().m;
//        (e-> System.out.println(
//                Period.between(e.getSprint().getFinishDate(),e.getSprint().getStartDate()).getDays()));

        model.addAttribute("maxFinishDate", maxFinishDate);
        model.addAttribute("minStartDate", minStartDate);
        model.addAttribute("project", project);
        model.addAttribute("title", "Show Project");
        model.addAttribute("path", "project/showProject");
        return "main";
    }

}