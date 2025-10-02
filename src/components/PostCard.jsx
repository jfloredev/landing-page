import React from 'react';

const PostCard = ({ post }) => {
  return (
    <div className="post-card">
      <h3>{post.title}</h3>
      <p>{post.body}</p>
      <div className="post-meta">
        <span>Post #{post.id}</span>
        <span>Usuario ID: {post.userId}</span>
      </div>
    </div>
  );
};

export default PostCard;
