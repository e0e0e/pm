package pl.sda.pms.sprint;

import org.springframework.stereotype.Service;
import pl.sda.pms.users.User;

import java.time.LocalDate;
import java.util.List;
import java.util.TimeZone;

@Service
public class SprintService {
    //    private final SprintRepository sprintRepository;
    private final SprintRepositoryJPA sprintRepositoryJPA;

    public SprintService(SprintRepositoryJPA sprintRepositoryJPA) {
        this.sprintRepositoryJPA = sprintRepositoryJPA;
    }


    public void saveSprint(LocalDate from, LocalDate to, Integer storyPoints) {
        TimeZone.setDefault(TimeZone.getTimeZone("GMT+1"));
        if (sprintRepositoryJPA.findIfDateAvalible(from.toString(), to.toString()) > 0) {
            throw new RuntimeException("Data range overlaps");
        }
        if(to.isBefore(from)){
            throw new RuntimeException("Date 'To' should be after 'from' ");
        }
        Sprint sprint = new Sprint(from, to, storyPoints);
        sprintRepositoryJPA.save(sprint);


    }



    public List<Sprint> findAllSprints() {
        return sprintRepositoryJPA.findAllSprintsSorted();
    }

    public User findUserByName(String name) {
        return sprintRepositoryJPA.findUserByName(name);

    }

    public void deleteSprint(long sprintId) {

        sprintRepositoryJPA.deleteById(sprintId);
    }

    public Sprint getSprint() {
        return sprintRepositoryJPA.getSprint();
    }

    public long findNextSprint(long sprintId) {
        Long result = sprintRepositoryJPA.findNextSprint(sprintId);
        if (result == null) {
            return -1L;

        }

        return result;
    }

    public long findPreviousSprint(long sprintId) {
        Long result = sprintRepositoryJPA.findPreviousSprint(sprintId);
        if (result == null) {
            return -1L;

        }
        return result;
    }

    public Sprint findById(Long sprintId) {
        return sprintRepositoryJPA.findById(sprintId).get();
    }

    public int findIfExists(LocalDate startDate1, LocalDate startDate2) {
        return sprintRepositoryJPA.findIfExists(startDate1,startDate2);
    }
}
