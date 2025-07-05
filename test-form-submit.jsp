<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Test Form Submit</title>
</head>
<body>
    <h2>Test Form Submit to FeedbackControl</h2>
    
    <form action="FeedbackControl" method="post">
        <input type="hidden" name="action" value="submit">
        <input type="hidden" name="invoiceId" value="1">
        
        <p>Rating:</p>
        <input type="radio" name="rating" value="5" id="r5"> <label for="r5">5 sao</label><br>
        <input type="radio" name="rating" value="4" id="r4"> <label for="r4">4 sao</label><br>
        <input type="radio" name="rating" value="3" id="r3"> <label for="r3">3 sao</label><br>
        <input type="radio" name="rating" value="2" id="r2"> <label for="r2">2 sao</label><br>
        <input type="radio" name="rating" value="1" id="r1"> <label for="r1">1 sao</label><br>
        
        <p>Content:</p>
        <textarea name="content" rows="3" cols="50">Test feedback content</textarea>
        
        <br><br>
        <button type="submit">Submit Test</button>
    </form>
    
    <hr>
    <p><a href="debug-simple.jsp">Xem feedback trong database</a></p>
    
</body>
</html> 