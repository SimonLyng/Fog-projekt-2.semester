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
        int post = 5; // Starts of as 4, because there is a minimum of 5 posts
        double extraPosts = 0.0;
        if(shed == true){ // If there is a shed connected, add 4 extra posts
            post += 4;
            extraPosts = floor((length-(2.5*widthPiece))/3.3)*2;
        }
        else {
            extraPosts = floor((length-(4*widthPiece))/3.3)*2;
        }
        System.out.println(extraPosts);
        return (int) (post+extraPosts);
    }

    public int calRafters(int objectLength){ // Udregner til spær
        int rafters = 2; // There is at least 2 rafters, 1 in each end
        double length = (double) objectLength/100;
        double extraRafters = floor(length/(widthPiece+0.045));
        System.out.println(rafters+extraRafters);
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

    public Map<String, Integer> calRemme(int objectLength){
        Map<String, Integer> output = new TreeMap<>();
        double length = (double) objectLength/100;
        double tempLengh = 0;
        int countLong = 0;
        int countShort = 0;
        while (tempLengh == 0 || tempLengh < length) {
            if (tempLengh + 4.8 >= length) {
                countShort++;
                break;
            } else if (tempLengh + 6.0 >= length) {
                countLong++;
                break;
            } else {
                countLong++;
                tempLengh += 6.0;
            }
        }
        output.put("long", countLong);
        output.put("short", countShort);
        return output;
    }

    public Map<String, Integer> calRemmeShed(int objectLength, int lengthLong, int lengthShort, int times){
        Map<String, Integer> output = new TreeMap<>();
        double materialLengthShort = (double) lengthShort/100;
        double materialLengthLong = (double) lengthLong/100;
        double length = (double) objectLength/100;
        double tempLengh = 0;
        int countLong = 0;
        int countShort = 0;
        while(tempLengh == 0 || tempLengh < length){
            if(materialLengthShort > length*2){
                countShort++;
                break;
            }
            else if(materialLengthLong > length*2){
                countLong++;
                break;
            }
            else{
                countLong++;
                tempLengh +=materialLengthLong;
            }
        }
        output.put("long", countLong * times);
        output.put("short", countShort * times);
        return output;
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
            System.out.println(tempLengh);
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
//        double gavl = ceil(length/2.7)*6;
//        return gavl;
//        Map<String, Double> output = new TreeMap<>();
//        double count = 0;
//        // Finder mængden af de længste sternbræder, der skal bruges til den givne længde først
//        while(count == 0 || (count*materialLengthLong)/length < 1){
//            count++;
//        }
//        // Tjekker om hvorvidt det "sidste" bræt i rækken, skal være 360 (mindste) eller 540 (længste) bræt.
//        // Hvis mængden af længste bræder (-1) + en af de mindste bræder, er over 1, vil det mindste bræt til sidste
//        // være "bedst"/kunne lade sig gøre.
//        if((((count-1)*materialLengthLong)+materialLengthShort)/length >= 1){
//            // Inkludere alle de lange bræder - times = antallet der "skal" bruges, eksempel er at der skal bruges
//            // 6 (3 på hver side) løsholter på en gavl, per 2.4-2.7 meter
//            output.put("long", (count-1)*times);
//            output.put("short", 1.0*times); // Inkludere det angivne antal af korte bræder
//        }
//        else {
//            output.put("long", count*times);
//        }
//        return output;
//    }

//    public double calLooseWoodSite(double width){ // Udregner til løsholter til skur (siden)
//        double site = ceil(width/2.4)*4;
//        return site;
//    }
//
//    // Udregner til stern af både under-, over
//    public Map<String, Double> calStern(double length){
//        Map<String, Double> output = new TreeMap<>();
//        double count = 0;
//        // Finder mængden af de længste sternbræder, der skal bruges til den givne længde først
//        while(count == 0 || (count*5.4)/length < 1){
//            count++;
//        }
//        // Tjekker om hvorvidt det "sidste" bræt i rækken, skal være 360 (mindste) eller 540 (længste) bræt.
//        // Hvis mængden af længste bræder (-1) + en af de mindste bræder, er over 1, vil det mindste bræt til sidste
//        // være "bedst"/kunne lade sig gøre.
//        if((((count-1)*5.4)+3.6)/length >= 1){
//            output.put("long", (count-1)*2); // Inkludere alle de lange bræder - gange 2, fordi der er en på hver side
//            output.put("short", 2.0); // Inkludere 2 korte bræder
//        }
//        else {
//            output.put("long", count*2);
//        }
//        return output;
//    }
}
