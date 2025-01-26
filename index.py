import React, { useState } from "react";
import axios from "axios";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";

const PS4GameUploader = () => {
  const [gameLink, setGameLink] = useState("");
  const [description, setDescription] = useState("");
  const [games, setGames] = useState([]);

  // Simulate uploading a game
  const handleUpload = async () => {
    if (!gameLink || !description) {
      alert("Por favor, completa todos los campos antes de subir el juego.");
      return;
    }

    const newGame = { link: gameLink, description };

    // Simulate backend storage (can be replaced with real API call)
    setGames((prevGames) => [...prevGames, newGame]);

    // Clear inputs
    setGameLink("");
    setDescription("");

    alert("Juego subido correctamente.");
  };

  return (
    <div className="p-8 bg-gray-100 min-h-screen">
      <h1 className="text-3xl font-bold mb-6">Gestor de Juegos para PS4</h1>

      {/* Formulario para subir juegos */}
      <Card className="mb-6 p-4">
        <CardContent>
          <h2 className="text-xl font-semibold mb-4">Subir un nuevo juego</h2>

          <div className="mb-4">
            <Input
              placeholder="Enlace de GitHub del juego"
              value={gameLink}
              onChange={(e) => setGameLink(e.target.value)}
            />
          </div>

          <div className="mb-4">
            <Textarea
              placeholder="Descripción del juego"
              value={description}
              onChange={(e) => setDescription(e.target.value)}
            />
          </div>

          <Button onClick={handleUpload}>Subir Juego</Button>
        </CardContent>
      </Card>

      {/* Listado de juegos */}
      <div>
        <h2 className="text-2xl font-semibold mb-4">Juegos Disponibles</h2>
        {games.length === 0 ? (
          <p>No hay juegos disponibles.</p>
        ) : (
          games.map((game, index) => (
            <Card key={index} className="mb-4 p-4">
              <CardContent>
                <p className="text-lg font-bold">{game.description}</p>
                <a
                  href={game.link}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-blue-500 underline"
                >
                  Descargar/Instalar
                </a>
              </CardContent>
            </Card>
          ))
        )}
      </div>
    </div>
  );
};

export default PS4GameUploader;
