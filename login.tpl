<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
    <title>MODX CMF Manager Login</title>
    <meta http-equiv="content-type" content="text/html; charset=[+modx_charset+]" />
    <meta name="robots" content="noindex, nofollow" />
    <style type="text/css">
		body {
			font-family: Arial, HelveticaNeue, "Helvetica Neue", Helvetica, "Hiragino Kaku Gothic Pro", Meiryo, sans-serif;
		}
		input {
			font-family:inherit;
		}
		#login {
			background: #eeeeee;
			margin: 12% 0 0;
		}
		#mx_loginbox {
			width: 309px;
			margin: 0 auto;
		}
		.sectionBody {
			border:1px solid #ddd;
			border-top: 3px solid #3697CD;
			background: #FEFEFE;
		    padding: 25px 0 0 20px;
			overflow: hidden;
		}
		.logo {
			margin: 0 0 0 14px;
		}
		.logo img{
			border: 0 none;
			margin: 0 0 17px;
		}
		.sectionBody label {
			color: #666666;
			display: block;
			font: 14px Arial;
			margin: 0 0 11px;
		}
		.sectionBody .text, #FMP-email {
			width: 261px;
			height: 33px;
			border: 1px solid #E5E5E5;
			text-indent: 5px;
			margin: 0 0 20px;
			font-size: 20px;
			-webkit-border-radius: 2px;
			-moz-border-radius: 2px;
			border-radius: 2px;
			transition: border-color 0.3s ease-out, box-shadow 0.3s ease-out
		}
		.sectionBody .text:focus, #FMP-email:focus {
			border: 1px solid #3697CD;
			box-shadow:         0 0 0 1px #3697CD;
			border-radius:0;
		}
		#rememberme {
			float: left;
			margin: 3px 5px 0 1px;
		}
		.sectionBody .remtext {
			color: #999999;
			display: block;
			float: left;
			font-size: 13px;
			margin: 0;
		} 
		#submitButton, #FMP-email_button {
			display: block;
			float: right;
			border: 0;
			border-radius:2px;
			padding: 8px 20px;
			cursor: pointer;
			color:#fff;
			font-size: 14px;
			font-weight: 100;
			margin:-7px 22px 10px 0;
			background:#58A598;
		}
			#submitButton:hover, #FMP-email_button {
				background:#51AD9C;
			}
		#submitButton:after {
			content:'';
			clear: both;
			display:block;
		}
		#onManagerLoginFormRender {
			clear: both;
			position:relative;
			border-top:1px solid #ddd;
			background:#f5f5f5;
			margin:30px 0 0 -20px;
			padding:20px;
			overflow:hidden;
		}
		#FMP-email_label {
			color: #666666;
			font: 13px Arial;
			margin: 0 0 7px;
		}
		/*
		#FMP-email {
			width: 261px;
			height: 33px;
			border: 1px solid #E5E5E5;
			text-indent: 5px;
			margin: 0 0 10px;
			font-size: 14px;
			-webkit-border-radius: 5px;
			-moz-border-radius: 5px;
			border-radius: 5px;
			-webkit-box-shadow: 0 0 5px rgba(188, 188, 188, 0.2);
			-moz-box-shadow:    0 0 5px rgba(188, 188, 188, 0.2);
			box-shadow:         0 0 5px rgba(188, 188, 188, 0.2);
		}
		#FMP-email:focus {
			border: 1px solid #DECBA5;
			-webkit-box-shadow: 0 0 5px rgba(222, 203, 165, 0.5);
			-moz-box-shadow:    0 0 5px rgba(222, 203, 165, 0.5);
			box-shadow:         0 0 5px rgba(222, 203, 165, 0.5);
		}
		*/
		#FMP-email_button {
			margin: 2px 0 0 0;
		}
		.loginLicense {
			width: 309px;
			margin: 0 auto;
			display: block;
		}
		.loginLicense a {
			color: #999999;
			display: block;
			font: 13px Arial;
			margin: 13px 0 0 21px;
			text-decoration: underline;
		}
		#ForgotManagerPassword-show_form {
			color: #999999;
			display: block;
			font: 13px Arial;
			margin: 0 0 10px;
			text-align: left;
		}
		.error {
			font: 13px Arial;
			color: #f00;
		}
		.gpl {
			position: absolute;
			bottom: 0;
			right: 0;
			color: #B2B2B2;
			margin: 0.5em auto;
			font-size: 80%;
		}
        .gpl a, .loginLicense a {
			color: #B2B2B2;
		}
    </style>

    <script src="media/script/mootools/mootools.js" type="text/javascript"></script>

    <script type="text/javascript">
    /* <![CDATA[ */
        if (top.frames.length!=0) {
            top.location=self.document.location;
        }
        
        window.addEvent('domready', function() {
            $('submitButton').addEvent('click', function(e) {
                 e = new Event(e).stop();
                 params = 'ajax=1&' + $('loginfrm').toQueryString();
                 url = 'processors/login.processor.php';
                 new Ajax(url,
                    {
                        method: 'post',
                        postBody: params,
                        onComplete:ajaxReturn
                    }
                ).request();
                $$('input').setProperty('readonly', 'readonly');
            });  
			
			// Initial focus
			if ($('username').value != '') {
				$('password').focus();
			} else {
				$('username').focus();
			}
			   
        });

        function ajaxReturn(response) {
            var header = response.substr(0,9);
            if (header.toLowerCase()=='location:') top.location = response.substr(10);
            else {
                var cimg = $('captcha_image');
                if (cimg) {
                	cimg.src = 'includes/veriword.php?rand=' + Math.random();
                }
                $$('input').removeProperty('readonly');
                alert(response);
            }
        }
    /* ]]> */
    </script>
</head>
<body id="login">
<div id="mx_loginbox">
    <form method="post" name="loginfrm" id="loginfrm" action="processors/login.processor.php">
    <!-- anything to output before the login box via a plugin? -->
    [+OnManagerLoginFormPrerender+]
        <div class="sectionHeader">
			<a class="logo" href="../" title="[+site_name+]">
				<img src="media/style/[+theme+]/images/misc/login-logo.png" alt="[+site_name+]" id="logo" />
			</a>
		</div>
        <div class="sectionBody">
            <!--<p class="loginMessage">[+login_message+]</p>-->
            <label for="username">[+username+]</label>
            <input type="text" class="text" name="username" id="username" tabindex="1" value="[+uid+]" />
            <label for="password">[+password+]</label>
            <input type="password" class="text" name="password" id="password" tabindex="2" value="" />
            <p class="caption">[+login_captcha_message+]</p>
            <div>[+captcha_image+]</div>
            [+captcha_input+]
            <input type="checkbox" id="rememberme" name="rememberme" tabindex="4" value="1" class="checkbox" [+remember_me+] />
			<label for="rememberme" style="cursor:pointer" class="remtext">[+remember_username+]</label>
            <input type="submit" class="login" id="submitButton" value="[+login_button+]" />
            <!-- anything to output before the login box via a plugin ... like the forgot password link? -->
            [+OnManagerLoginFormRender+]
        </div>
    </form>
</div>
<!-- close #mx_loginbox -->

<!-- convert this to a language include -->
<p class="loginLicense" >
	
</p>
<div class="gpl">&copy; 2005-2014 by the <a href="http://modx.com/" target="_blank">MODX</a>. <strong>MODX</strong>&trade; is licensed under the GPL.</div>
</body>
</html>