package com.univ.action;

import com.opensymphony.xwork2.ActionSupport;
import com.univ.entity.SshExampleEntity;
import com.univ.service.ISshExampleService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * created by Univ
 * 16/5/19 16:43
 */
public class SshExampleAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	@Autowired
	private ISshExampleService sshExampleService;

    private List<SshExampleEntity> sshExampleList;
    private SshExampleEntity sshExample;

    public String toSave(){
    	return "toSave";
    }

    public String save() {
    	sshExampleService.save(sshExample);
        return toList();
    }
    
    public String toUpdate(){
    	sshExample = sshExampleService.get(sshExample.getId());
    	return "toUpdate";
    }

    public String update(){
    	sshExampleService.update(sshExample);
        return toList();
    }
    
    public String delete(){
    	sshExampleService.delete(sshExample);
    	return toList();
    }

    public String toList() {
        sshExampleList =  sshExampleService.getAll();
        return "toList";
    }


    //--------------------------getter and setter---------------------------------------
    public List<SshExampleEntity> getSshExampleList() {
        return sshExampleList;
    }

    public void setSshExampleList(List<SshExampleEntity> sshExampleList) {
        this.sshExampleList = sshExampleList;
    }

    public SshExampleEntity getSshExample() {
        return sshExample;
    }

    public void setSshExample(SshExampleEntity sshExample) {
        this.sshExample = sshExample;
    }
}
