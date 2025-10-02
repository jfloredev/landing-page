import React, { useState, useEffect } from 'react';
import { getPosts } from '../services/api';
import PostCard from './PostCard';
import LoadingSpinner from './LoadingSpinner';

const PostsSection = () => {
  const [posts, setPosts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchPosts = async () => {
      try {
        setLoading(true);
        const data = await getPosts(6);
        setPosts(data);
      } catch (err) {
        setError('Error al cargar los artículos');
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    fetchPosts();
  }, []);

  if (loading) return <LoadingSpinner message="Cargando artículos..." />;
  if (error) return <div className="error">{error}</div>;

  return (
    <section id="posts" className="section">
      <div className="container">
        <h2>Artículos Recientes</h2>
        <div className="posts-grid">
          {posts.map(post => (
            <PostCard key={post.id} post={post} />
          ))}
        </div>
      </div>
    </section>
  );
};

export default PostsSection;
