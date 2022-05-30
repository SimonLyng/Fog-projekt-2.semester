package dat.examproject.model.persistence;

import dat.examproject.model.entities.Order;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;
import java.util.TreeMap;

import static java.lang.Math.ceil;
import static java.lang.Math.floor;

public class Calculator {

    // 38x73 lægte gives 1 af (til dør), hvis der er skur
    // 45x195 mm. spærtræ ubh. gives 2 af, enten af længden 480 eller 600, afængig af carporterns længde
    // 25x200 mm. trykkimp. Brædt: 2 stk. per 360
    double widthPiece = 0.55;
    public int calPost(int objectLength, boolean shed){ // Udregner til Stolper
        // Starter med 4, hvis der er skur på, skal der være 4 ekstra, og så skal der sættes 2 ind per 3-3,3 meter
        double length = (double) objectLength/100;
        int post = 5; // Starts of as 5, because there is a minimum of 5 posts
        double extraPosts = 0.0;
        if(shed == true){ // If there is a shed connected, add 4 extra posts
            post += 4;
            extraPosts = floor((length-(2.5*widthPiece))/3.3)*2;
        }
        else {
            extraPosts = floor((length-(4*widthPiece))/3.3)*2;
        }
        return (int) (post+extraPosts);
    }

    public int calRafters(int objectLength){ // Udregner til spær
        int rafters = 2; // There is at least 2 rafters, 1 in each end
        double length = (double) objectLength/100;
        double extraRafters = floor(length/(widthPiece+0.045));
        return (int) (rafters+extraRafters);
    }

    public int calShedBoards(int objectLength, int objectWidth){ // Udregner til bræder til skur
        double length = (double) objectLength/100;
        double width = (double) objectWidth/100;
        double lengthBoards = length*0.2; // Der går 10 bræder på hver meter, og der er 2 sider = 0.2
        double widthBoards = width*0.2; // -||-
        int total = (int) ceil(lengthBoards+widthBoards)*100; // Sælger kun bundter af 100 (så vidt ses), derfor denne ligning
        return total;
    }

    // Løsholter gavl = gang resultat af bræder med 6
    // Løsholter side = gange resultat af bræder med 4
    // Stern af alle varianter = gange resultat af bræder med 2 (med undtagelse af overstærnsbrædder til forenden)

    public Map<String, Integer> calMultiple(int objectLength, int lengthLong, int lengthShort,
                                                int times) { // Udregner til alle sternbrædder og løsholter
        Map<String, Integer> output = new TreeMap<>();
        double materialLengthShort = (double) lengthShort/100;
        double materialLengthLong = (double) lengthLong/100;
        double length = (double) objectLength/100;
        double tempLengh = 0;
        int countLong = 0;
        int countShort = 0;
        while (tempLengh == 0 || tempLengh < length) {
            if ((tempLengh + materialLengthShort) >= length) {
                countShort++;
                tempLengh += materialLengthShort;
            } else if (countLong == 0 && tempLengh + (materialLengthShort * 2) >= length && tempLengh + materialLengthLong < length) {
                countShort += 2;
                tempLengh += materialLengthShort*2;
            } else {
                countLong++;
                tempLengh += materialLengthLong;
            }
        }
        output.put("long", countLong * times);
        output.put("short", countShort * times);
        return output;
    }

    public Map<String, Integer> calRoof(int objectWidth, int objectLength){
        Map<String, Integer> output = new TreeMap<>();
        double width = (double) objectWidth/100;
        double length = (double) objectLength/100;
        double roofL = 6.0;
        double roofS = 3.6;
        double roofWidth = 0.8125;
        double tempKvm2 = 0;
        double countfL = 0;
        double countfS = 0;

        while(tempKvm2 == 0 || tempKvm2 <= length){
            if(roofS >= width){
                countfS++;
            }
            else if(roofL >= width){
                countfL++;
            }
            else if(roofS*2 >= width){
                countfS+=2;
            }
            else{
                countfL+=2;
            }
                tempKvm2 += roofWidth;
        }
        output.put("long", (int) ceil(countfL));
        output.put("short", (int) ceil(countfS));
        return output;
    }

    public ArrayList<Integer> calScrews(int objectWidth, int objectLength){
        double width = (double) objectWidth/100;
        double length = (double) objectLength/100;
        ArrayList<Integer> output = new ArrayList<>();
        ArrayList<Integer> amounts = new ArrayList<>(
                Arrays.asList(3,2,15,15,1,3,18,12,2,2,1,2,32)
        );

        for(int i = 0; i < amounts.size(); i++){
            output.add((int) ceil((amounts.get(i)/46.8)*(width*length)));
        }
        return output;
    }
}
