package wvutech.labassist.beans;

import static wvutech.labassist.beans.Department.DepartmentID;

public class Class {
	public final int cid;

	public final DepartmentID department;

	public final String name;

	public Class(int id, DepartmentID dept, String nam) {
		cid = id;

		department = dept;

		name = nam;
	}
}
