import axios from 'axios';

const API_BASE_URL = 'https://jsonplaceholder.typicode.com';

const api = axios.create({
  baseURL: API_BASE_URL,
  timeout: 10000,
});

// Posts API
export const getPosts = async (limit = 6) => {
  try {
    const response = await api.get(`/posts?_limit=${limit}`);
    return response.data;
  } catch (error) {
    console.error('Error fetching posts:', error);
    throw error;
  }
};

// Users API
export const getUsers = async (limit = 8) => {
  try {
    const response = await api.get(`/users?_limit=${limit}`);
    return response.data;
  } catch (error) {
    console.error('Error fetching users:', error);
    throw error;
  }
};

// Comments API (for stats)
export const getComments = async () => {
  try {
    const response = await api.get('/comments');
    return response.data;
  } catch (error) {
    console.error('Error fetching comments:', error);
    throw error;
  }
};

// Photos API (for stats)
export const getPhotos = async () => {
  try {
    const response = await api.get('/photos');
    return response.data;
  } catch (error) {
    console.error('Error fetching photos:', error);
    throw error;
  }
};
