package dat.examproject.model.entities;

import java.util.Objects;

public class User
{
    private int idUser;
    private String mail;
    private String password;
    private String name;
    private String phone;
    private int idCard;
    private String role;

    public User(int idUser, String mail, String password, String name, String phone, int idCard, String role) {
        this.idUser = idUser;
        this.mail = mail;
        this.password = password;
        this.name = name;
        this.phone = phone;
        this.idCard = idCard;
        this.role = role;
    }

    public String getPhone() {
        return phone;
    }

    public int getIdCard() {
        return idCard;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String username)
    {
        this.name = username;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getPassword()
    {
        return password;
    }

    public void setPassword(String password)
    {
        this.password = password;
    }

    public String getRole()
    {
        return role;
    }

    public void setRole(String role)
    {
        this.role = role;
    }

    public int getIdUser() {
        return idUser;
    }

    @Override
    public String toString() {
        return "User{" +
                "idUser=" + idUser +
                ", mail='" + mail + '\'' +
                ", password='" + password + '\'' +
                ", name='" + name + '\'' +
                ", phone=" + phone +
                ", idCard=" + idCard +
                ", role='" + role + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o)
    {
        if (this == o) return true;
        if (!(o instanceof User)) return false;
        User user = (User) o;
        return getMail().equals(user.getMail()) && getPassword().equals(user.getPassword()) &&
                getIdUser() == user.getIdUser() && getName().equals(user.getName()) &&
                getPhone().equals(user.getPhone()) && getIdCard() == user.getIdCard() &&
                getRole().equals(user.getRole());
    }

    @Override
    public int hashCode()
    {
        return Objects.hash(getName(), getPassword(), getRole());
    }
}
