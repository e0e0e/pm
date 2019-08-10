package pl.sda.springdemo.task;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pl.sda.springdemo.progres.Progress;
import pl.sda.springdemo.projects.ProjectService;
import pl.sda.springdemo.sprint.SprintService;
import pl.sda.springdemo.users.UserService;

import java.time.LocalDate;
import java.util.List;

@Controller
public class TaskController {
    private final UserService userService;
    private final SprintService sprintService;
    private final TaskService taskService;
    private final ProjectService projectService;

    public TaskController(UserService userService, SprintService sprintService, TaskService taskService, ProjectService projectService) {
        this.userService = userService;
        this.sprintService = sprintService;


        this.taskService = taskService;
        this.projectService = projectService;
    }
//    private final TaskService taskService;


    @GetMapping("/tasks")
    public String taskForm(@RequestParam(required = false) Long projectId,
                           Model model) {


        model.addAttribute("project", projectService.findById(projectId).get());
        model.addAttribute("users", userService.findAll());
       // model.addAttribute("sprints", sprintService.findAllSprints());
        model.addAttribute("title", "Task form");
        model.addAttribute("path", "task/task");
        return "main";
    }

    @PostMapping("/tasks")
    public String addTask(@RequestParam String name,
                          @RequestParam String description,
                          @RequestParam String from,
                          @RequestParam String to,
                          @RequestParam Integer storyPoints,
                          @RequestParam Integer weight,
                          @RequestParam Long userId,
                          @RequestParam Long projectId,
                          Model model) {
        System.out.println("Task name: " + name);

        boolean tastCreated = taskService.create(name, description,
                LocalDate.parse(from),
                LocalDate.parse(to),
                storyPoints, weight,
                userService.findById(userId),
                projectService.findById(projectId).get()
        );

        model.addAttribute("createUserResult", tastCreated);

        return "redirect:/project/show?projectId=" + projectId;
    }

    @GetMapping("/taskList")
    public String showTasks(Model model) {
        List<Task> tasks = taskService.findAll();
        model.addAttribute("tasks", tasks);
        model.addAttribute("title", "Add Task");
        model.addAttribute("path", "task/taskList");
        return "main";

    }

    @GetMapping("/task/progressChange")
    public String changeProgress(@RequestParam Long taskId,
                                 Model model) {

        Task task = taskService.findById(taskId);
        model.addAttribute("progress", Progress.values());
        model.addAttribute("task", task);
        model.addAttribute("title", "Change Progress");
        model.addAttribute("path", "task/changeProgress");
        return "main";
    }

    @PostMapping("/task/progressChange")
    private String changeProgress(@RequestParam Long taskId,
                                  @RequestParam String progress,
                                  Model model) {

        taskService.changeProgress(taskId, progress);

//        model.addAttribute("project", taskService.findById(taskId).getProject());
        model.addAttribute("title", "Show Project");
        model.addAttribute("path", "project/showProject");

        return "redirect:/project/show?projectId=" + taskService.findById(taskId).getProject().getId();
    }

    @GetMapping("/task/delete")
    public String deleteTask(@RequestParam long taskId,
                             @RequestParam long projectId) {

        taskService.DeleteTask(taskId);

        return "redirect:/project/show?projectId=" + projectId;

    }

    @GetMapping("/taskWall")
    private String showWall(Model model){

        List<Task> taskList=taskService.findAll();
        List<Task> tasksToDo=taskService.findToDo();


        model.addAttribute("tasksToDo",tasksToDo);
        model.addAttribute("tasks", taskList);

        model.addAttribute("title", "Wall");
        model.addAttribute("path", "task/taskWall");
        return "main";
    }


}
