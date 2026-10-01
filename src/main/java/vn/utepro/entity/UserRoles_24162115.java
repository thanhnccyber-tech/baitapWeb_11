package vn.utepro.entity;

import jakarta.persistence.*;

@Entity(name = "UserRoles")
@Table(name = "UserRoles")
public class UserRoles_24162115 {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int roleId;
    private String roleName;

    public UserRoles_24162115() {}

    public UserRoles_24162115(int roleId, String roleName) {
        this.roleId = roleId;
        this.roleName = roleName;
    }

    public int getRoleId() { return roleId; }
    public void setRoleId(int roleId) { this.roleId = roleId; }

    public String getRoleName() { return roleName; }
    public void setRoleName(String roleName) { this.roleName = roleName; }
}