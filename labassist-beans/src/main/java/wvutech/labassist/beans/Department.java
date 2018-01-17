package wvutech.labassist.beans;

public class Department {
	public static class DepartmentID {
		public final String deptid;

		public DepartmentID(String id) {
			if(id.length() > 4) {
				deptid = id.substring(0, 4);
			} else {
				deptid = id;
			}
		}
	}

	public final DepartmentID deptid;

	public final String deptname;

	public Department(DepartmentID id, String name) {
		deptid = id;

		deptname = name;
	}

	public String toString() {
		return String.format("department[id=%s,name=%s]", deptid, deptname);
	}
}
