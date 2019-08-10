package pl.sda.springdemo.users;


import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class UserService {

    private final UserRepository userRepository;
    private User logged = null;


    private final static Map<String, User> usersByEmail = new HashMap<>();

    public UserService(UserRepository userRepository) {

        this.userRepository = userRepository;

    }


    public boolean create(String login, String password, String email, String userName) {
        boolean isEmailTaken = userRepository.findAll().stream()
                .anyMatch(u -> u.getEmail().equals(email));

        if (isEmailTaken) {
            throw new RuntimeException("Email already in use");
        }
        User user = new User(login, password, email, userName);
        User created = userRepository.save(user);

        //usersByEmail.put(user.getEmail(), user);

        return created.getId() != null;
    }

    public List<User> findAll() {

        return userRepository.findAll();

    }

    public void delete(long userId) {

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not Found"));

        userRepository.delete(user);
    }

    public User findById(Long userId) {
        return userRepository.findById(userId).get();
    }


    public void save(User user) {
        userRepository.save(user);
    }

    public void login(String userName, String password) {
        logged = userRepository.findAll().stream()
                .filter(e -> (e.getUsername().equals(userName) && e.getPassword().equals(password)))
                .findAny()
                .orElse(null);

        // return user;

    }

    public User getLogged() {
        return logged;
    }

    public void logout() {
        logged = null;
    }


    public List<User> findUsersByEmail(String filterUserByEmail) {


        return userRepository.findUsersByEmail(filterUserByEmail);
    }
}
