package dat.examproject.model.entities;

import java.util.ArrayList;

public class StykList {
    private ArrayList<RT> rtList = new ArrayList<>();
    private ArrayList<SF> sfList = new ArrayList<>();

    public StykList(ArrayList<RT> rtList, ArrayList<SF> sfList) {
        this.rtList = rtList;
        this.sfList = sfList;
    }

    public ArrayList<RT> getRtList() {
        return rtList;
    }

    public void setRtList(ArrayList<RT> rtList) {
        this.rtList = rtList;
    }

    public ArrayList<SF> getSfList() {
        return sfList;
    }

    public void setSfList(ArrayList<SF> sfList) {
        this.sfList = sfList;
    }

    public void addRtList(RT rt){
        this.rtList.add(rt);
    }

    public void addSfList(SF sf){
        this.sfList.add(sf);
    }

    public boolean arrayEquals(ArrayList a, ArrayList b){
        boolean outcome = true;
        if(a.size() == b.size()){
            for(int i = 0; i < a.size(); i++){
                a.get(i).equals(b.get(i));
            }
        }
        else{
            outcome = false;
        }
        return outcome;
    }

    @Override
    public boolean equals(Object sl)
    {
        if (this == sl) return true;
        if (!(sl instanceof StykList)) return false;

        StykList stykList = (StykList) sl;
        return arrayEquals(getSfList(), stykList.getSfList()) && arrayEquals(getRtList(), stykList.getRtList());
    }


}
