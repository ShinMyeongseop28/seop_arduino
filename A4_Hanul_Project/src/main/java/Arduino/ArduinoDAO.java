package Arduino;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ArduinoDAO {
	private DBConnection pool;

	public ArduinoDAO() {
		try {
			pool = DBConnection.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 자료 추가
	public boolean Arduino_Insert(Arduino1DTO bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		Date nowTime = new Date();
		SimpleDateFormat nalja_f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		try {
			con = pool.getConnection();
			sql = "insert 04_arduino (f01,f02,f03,f04,f05,f07) values (?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getF01());
			pstmt.setString(2, bean.getF02());
			pstmt.setString(3, bean.getF03());
			pstmt.setString(4, bean.getF04());
			pstmt.setString(5, bean.getF05());
			pstmt.setString(6, nalja_f.format(nowTime));
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
}
