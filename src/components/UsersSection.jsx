import React, { useState, useEffect } from 'react';
import { getUsers } from '../services/api';
import UserCard from './UserCard';
import LoadingSpinner from './LoadingSpinner';

const UsersSection = () => {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        setLoading(true);
        const data = await getUsers(8);
        setUsers(data);
      } catch (err) {
        setError('Error al cargar los usuarios');
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    fetchUsers();
  }, []);

  if (loading) return <LoadingSpinner message="Cargando usuarios..." />;
  if (error) return <div className="error">{error}</div>;

  return (
    <section id="users" className="section">
      <div className="container">
        <h2>Nuestro Equipo</h2>
        <div className="users-grid">
          {users.map(user => (
            <UserCard key={user.id} user={user} />
          ))}
        </div>
      </div>
    </section>
  );
};

export default UsersSection;
