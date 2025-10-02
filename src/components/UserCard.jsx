import React from 'react';

const UserCard = ({ user }) => {
  const getInitials = (name) => {
    return name
      .split(' ')
      .map(word => word[0])
      .join('')
      .substring(0, 2)
      .toUpperCase();
  };

  return (
    <div className="user-card">
      <div className="user-avatar">
        {getInitials(user.name)}
      </div>
      <h3>{user.name}</h3>
      <p><strong>@{user.username}</strong></p>
      <div className="user-contact">
        <p><strong>Email:</strong> {user.email}</p>
        <p><strong>Teléfono:</strong> {user.phone}</p>
        <p><strong>Website:</strong> {user.website}</p>
        <p><strong>Ciudad:</strong> {user.address.city}</p>
      </div>
    </div>
  );
};

export default UserCard;
