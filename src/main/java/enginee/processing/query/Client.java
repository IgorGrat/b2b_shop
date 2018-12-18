package enginee.processing.query;
import javax.persistence.*;

@Entity
@Table(name = "Clients")
public class Client {
    private static String user="LAUser";
    @Id
    @GeneratedValue
    @Column(name = "id")
    private long id;
    @Column(name = "login")
    private String login;
    @Column(name = "password")
    private String password;
    @Column(name = "num")
    private String num;

    public Client() {
    }

    public Client(String login, String password, String num) {
        this.login = login;
        this.password = password;
        this.num= num;
    }
	 public String getNum() {
  return num;
 }

    public String getLogin() {return login;}

    public boolean isAccess(String password){
        return password.equals(this.password);
    }

    public static String getUser() {return user;}
}
