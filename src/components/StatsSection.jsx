import React, { useState, useEffect } from 'react';
import { getPosts, getUsers, getComments, getPhotos } from '../services/api';
import LoadingSpinner from './LoadingSpinner';

const StatsSection = () => {
  const [stats, setStats] = useState({
    posts: 0,
    users: 0,
    comments: 0,
    photos: 0
  });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchStats = async () => {
      try {
        setLoading(true);
        const [postsData, usersData, commentsData, photosData] = await Promise.all([
          getPosts(100),
          getUsers(10),
          getComments(),
          getPhotos()
        ]);

        setStats({
          posts: postsData.length,
          users: usersData.length,
          comments: commentsData.length,
          photos: photosData.length
        });
      } catch (error) {
        console.error('Error fetching stats:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchStats();
  }, []);

  if (loading) return <LoadingSpinner message="Cargando estadísticas..." />;

  return (
    <section id="stats" className="section">
      <div className="container">
        <div className="stats">
          <h2>Estadísticas en Tiempo Real</h2>
          <div className="stats-grid">
            <div className="stat-item">
              <h3>{stats.posts}</h3>
              <p>Artículos Publicados</p>
            </div>
            <div className="stat-item">
              <h3>{stats.users}</h3>
              <p>Usuarios Registrados</p>
            </div>
            <div className="stat-item">
              <h3>{stats.comments}</h3>
              <p>Comentarios Totales</p>
            </div>
            <div className="stat-item">
              <h3>{stats.photos}</h3>
              <p>Fotos Compartidas</p>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default StatsSection;
