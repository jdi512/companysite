package com.naver.domain;

import lombok.Data;

@Data
public class MasterVO {
	private Long seq;
	private String majorCode;//대분류
	private String majorName;
	private int middleCode;//중분류
	private String middleName;
	private int subCode;//소[세]분류
	private String subName;
	private int detailedCode;//세세분류
	private String detailedName;
}
