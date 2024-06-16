devise_for :users,
           path: '/auth',
           controllers: {
             omniauth_callbacks: 'omniauth',
             registrations: 'registrations'
           }
