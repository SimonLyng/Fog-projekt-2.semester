//package dat.examproject.control;
//import dat.examproject.model.entities.User;
//
//import java.util.Properties;
//import java.util.Random;
//import javax.mail.Authenticator;
//import javax.mail.Message;
//import javax.mail.PasswordAuthentication;
//import javax.mail.Session;
//import javax.mail.Transport;
//import javax.mail.internet.InternetAddress;
//import javax.mail.internet.MimeMessage;
//
//public class SendEmail {
//    //generate verification code
//    public String getRandom() {
//        Random rnd = new Random();
//        int number = rnd.nextInt(999999);
//        return String.format("%06d", number);
//    }
//
//    //send email to the user email
//    public boolean sendEmail(User user) {
//        boolean test = false;
//
//        String toEmail = user.getMail();//find deres mail
//        String fromEmail = "fogprojectgruppe1@gmail.com";//Sendes fra vores mail
//        String password = "fogprojekt1";
//
//        try {
//
//            // your host email smtp server details
//            // SMTP stands for Simple Mail Transfer Protocol, and it's an application used by mail servers to send, receive, and/or relay outgoing mail between email senders and receivers.
//            Properties pr = new Properties();
//            pr.setProperty("mail.smtp.host", "smtp.mail.com");
//            pr.setProperty("mail.smtp.port", "587");
//            pr.setProperty("mail.smtp.auth", "true");
//            pr.setProperty("mail.smtp.starttls.enable", "true");
//            pr.put("mail.smtp.socketFactory.port", "587");
//            pr.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
//
//            //get session to authenticate the host email address and password
//            Session session = Session.getInstance(pr, new Authenticator() {
//                @Override
//                protected PasswordAuthentication getPasswordAuthentication() {
//                    return new PasswordAuthentication(fromEmail, password);
//                }
//            });
//
//            //set email message details
//            Message mess = new MimeMessage(session);
//
//            //set from email address
//            mess.setFrom(new InternetAddress(fromEmail));
//            //set to email address or destination email address
//            mess.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
//
//            //set email subject
//            mess.setSubject("Ordre er klar");
//
//            //set message text
//            mess.setText("Din bestilling er nu klar, log ind på hjemmesiden for at kunne se den");
//            //send the message
//            Transport.send(mess);
//
//            test=true;
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return test;
//    }
//}
//
//
//
