package arduino;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;


public class Test_arduinoDAO {

	private DBConnection pool;

	public Test_arduinoDAO() {
		try {
			pool = DBConnection.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// arduino ===============================================================================
	// 자료 추가
	public boolean Arduino_Save(String v01, String v02, String v03, String v04) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;

		try {
			con = pool.getConnection();
			sql = "insert 05_arduino (usma,pin,name,control) values (?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, v01);
			pstmt.setString(2, v02);
			pstmt.setString(3, v03);
			pstmt.setString(4, v04);
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}

		return flag;
	}
	
	// 자료 추가
	public boolean Arduino_Insert(Test_arduinoDTO bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;

		try {
			con = pool.getConnection();
			sql = "insert 05_arduino (usma,pin,name,control) values (?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUsma());
			pstmt.setString(2, bean.getPin());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getControl());
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	// 자료 조회 전체(전체 자료 확인하기 위함)
	public Vector<Test_arduinoDTO> Arduino_Get() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<Test_arduinoDTO> vlist = new Vector<Test_arduinoDTO>();
		try {
			con = pool.getConnection();
			sql = "select * from 05_arduino";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Test_arduinoDTO bean = new Test_arduinoDTO();
				bean.setNumb(rs.getInt("numb"));
				bean.setUsma(rs.getString("usma"));
				bean.setPin(rs.getString("pin"));
				bean.setName(rs.getString("name"));
				bean.setControl(rs.getString("control"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// ON OFF 제어값 변경
	public boolean Arduino_Update_Perm(int recnum, String perm) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			if(perm.equals("ONOOO")) {
				sql = "update 05_arduino set control='OFFOO' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			} else {
				sql = "update 05_arduino set control='ONOOO' where numb=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, recnum);
			}
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}