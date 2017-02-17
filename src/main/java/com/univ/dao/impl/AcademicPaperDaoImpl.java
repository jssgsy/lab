package com.univ.dao.impl;

import com.univ.dao.AcademicPaperDao;
import com.univ.entity.AcademicPaper;
import com.univ.entity.EasyUIPage;
import com.univ.entity.User;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

/**
 * Univ
 * 2017/1/11 20:56
 */

@Repository
public class AcademicPaperDaoImpl extends AbstractBaseDao implements AcademicPaperDao {

    public void save(AcademicPaper paper) {
        getCurrentSession().save(paper);
    }

    public void update(AcademicPaper paper) {
        getCurrentSession().update(paper);
    }

    public void delete(AcademicPaper paper) {
        getCurrentSession().delete(paper);
    }

    //todo:或许可以参考RoleDaoImpl的getLinkedMenus方法
    public List<AcademicPaper> getPaginationWithQuery(AcademicPaper paper, EasyUIPage easyUIPage) {
        String authorName = paper.getAuthorList().get(0).getUsername();
        Query query = getCurrentSession().createQuery("from com.univ.entity.AcademicPaper  where name like :name");
        query.setString("name", "%" + paper.getName() + "%");
        query.setFirstResult(easyUIPage.getWhichPage());
        query.setMaxResults(easyUIPage.getPageSize());
        List<AcademicPaper> list = query.list();

        //根据作者名查询，这里实现的不够优雅，不过应该配置的是单向的多对多，似乎也别无他法。
        List<AcademicPaper> resultList = new ArrayList<AcademicPaper>();
        for(AcademicPaper p : list){
            List<User> authorList = p.getAuthorList();
            for(User author : authorList){
                if (author.getUsername().contains(authorName)) {
                    resultList.add(p);
                    break;
                }
            }
        }
        return resultList;
    }

    public long totalSize() {
        return ((Number)getCurrentSession().createQuery("select count(id) from com.univ.entity.AcademicPaper").uniqueResult()).intValue();
    }
}
