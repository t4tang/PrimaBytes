<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PRIMA_HRIS.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link href="styles/style.css" rel="stylesheet" />
    <script type="text/javascript" src="scripts/script.js" defer></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            document.getElementById("btn_submit").addEventListener("click", function () {
                // Panggil fungsi C# di sini
                DotNet.invokeMethodAsync('PRIMA_CONNECT', 'login_submit')
                    .then(data => {
                        console.log(data);
                    });
            });
        </script>
    </telerik:RadCodeBlock>
</head>
<body>
    <header>
        <nav class="navbar">
            <span class="hamburger-btn material-symbols-rounded">menu</span>
            <a class="logo">
                <%--<img src="images/prima.png" alt="logo" />--%>
                <h2>PrimaBytes</h2>
            </a>
            <ul class="links">
                <span class="close-btn material-symbols-rounded">close</span>
                <%--<li><a href="#">Home</a></li>
                <li><a href="#">Portfolio</a></li>
                <li><a href="#">Courses</a></li>
                <li><a href="#">About us</a></li>
                <li><a href="#">Contact us</a></li>--%>
            </ul>
            <button class="login-btn">LOG IN</button>
        </nav>
    </header>
    <div class="blur-bg-overlay"></div>
    <div class="form-popup" >
        <span class="close-btn material-symbols-rounded">close</span>
        <div class="form-box login">
            <div class="form-details">
                <h2>Welcome Back</h2>
                <p>Please log in using your username and password to stay connected with PrimaBytes Application</p>
            </div>
            <div class="form-content">
                <h2>LOGIN</h2>
                <form action="#" runat="server">
                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    <div class="input-field">
                        <%--<input type="text" required id="txt_uid" />--%>
                        <input runat="server" type="text" required="required" id="txt_uid" />
                        <label>Username</label>
                    </div>
                    <div class="input-field">
                        <%--<input type="password" required id="txt_pass" />--%>
                        <input runat="server" type="password" required="required" id="txt_pass" />
                        <label>Password</label>
                    </div>
                   <%-- <a href="#" class="forgot-pass-link">Forgot password?</a>--%>
                    <%--<button id="btn_submit">Log In</button>--%>
                    <%--<asp:Button OnClick="login_submit" Text="Login" runat="server" />--%>
                    <telerik:RadButton ID="btn_submit" OnClick="btn_submit_Click" Text="Login" runat="server" 
                        Skin="Telerik" Height="40px" BackColor="#99ccff"></telerik:RadButton>
                </form>
                <%--<div class="bottom-link">
                    Don't have an account?
                    <a href="#" id="signup-link">Signup</a>
                </div>--%>
            </div>
        </div>
        <div class="form-box signup">
            <div class="form-details">
                <h2>Create Account</h2>
                <p>To become a part of our community, please sign up using your personal information.</p>
            </div>
            <div class="form-content">
                <h2>SIGNUP</h2>
                <form action="#">
                    <div class="input-field">
                        <input type="text" required />
                        <label>Enter your email</label>
                    </div>
                    <div class="input-field">
                        <input type="password" required />
                        <label>Create password</label>
                    </div>
                    <div class="policy-text">
                        <input type="checkbox" id="policy">
                        <label for="policy">
                            I agree the
                            <a href="#" class="option">Terms & Conditions</a>
                        </label>
                    </div>
                    <button type="submit">Sign Up</button>
                </form>
                <div class="bottom-link">
                    Already have an account? 
                    <a href="#" id="login-link">Login</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
