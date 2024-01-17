package com.naver.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import com.naver.domain.AttachVO;
import com.naver.mapper.AttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {
	
	@Setter(onMethod_ = @Autowired)
	private AttachMapper attachMapper;

	@Scheduled(cron="0 0 10 * * *")
	public void checkFiles() throws Exception {
		log.warn("File Check Task run....");
		log.warn("================================");
		
		List<AttachVO> fileList = attachMapper.getOldFiles();
		
		//fileList에 있는 정보로 파일의 경로 구한다.
		List<Path> fileListPaths = fileList.stream()
				.map(vo -> Paths.get("d:/upload", vo.getUploadPath(), vo.getUuid() + "_" +vo.getFileName()))
				.collect(Collectors.toList());
		//fileList에 있는 정보로 이미지파일일 경우 파일의 경로를 fileListPaths에 추가한다.
		fileList.stream().filter(vo -> vo.isFileType() == true)
				.map(vo -> Paths.get("d:/upload", vo.getUploadPath(), "s_" + vo.getUuid() + "_" +vo.getFileName()))
				.forEach(p -> fileListPaths.add(p));
		
		//어제 디렉토리의 파일을 구한다.
		File targetDir = Paths.get("d:/upload", getFolderYesterDay()).toFile();
		//어제 디렉토리에 있는 파일을 조회하면서 fileListPaths에 저장되어있지 않으면 removeFiles 배열에 저장한다.
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		
		//배열에 있는 파일을 삭제한다.
		for( File file : removeFiles) {
			file.delete();
		}
	}

	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}
}
