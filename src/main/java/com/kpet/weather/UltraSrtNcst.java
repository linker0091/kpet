package com.kpet.weather;

import lombok.Data;
import lombok.Getter;

/**
 * 동네예보 서비스 도메인
 *
 * @author hgko
 *
 */
@Data
public class UltraSrtNcst {

  /** 발표일자 */
  private String baseDate;

  /** 발표시각 */
  private String baseTime;

  /** 자료구분문자 */
  private CategoryType category;

  /** 실황 값 */
  private String obsrValue;

  /** 예보지점 X 좌표 */
  private float nx;

  /** 예보지점 Y 좌표 */
  private float ny;

  /**
   * 코드값 정보
   * [T1H,RN1,UUU,VVV,REH,PTY,VEC,WSD]
   */
  @Getter
  public enum CategoryType {
	  T1H("기온", "℃"),
	  RN1("1시간 강수량", "mm"),
	  UUU("동서바람성분", "m/s"),
	  VVV("남북바람성분", "m/s"),
	  REH("습도", "%"),
	  PTY("강수형태", "코드값"),
	  VEC("풍향", "deg"),
	  WSD("풍속", "m/s");
  
    private String name;

    private String unit;

    private CategoryType(String name, String unit) {
      this.name = name;
      this.unit = unit;
    }
  }
}
