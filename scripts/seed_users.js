const admin = require('firebase-admin');
const fs = require('fs');

const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const firestore = admin.firestore();
const auth = admin.auth();

const users = [
  {
    email: 'admin@bagfinder.com',
    password: 'admin1234!',
    fullName: 'Administrador Geral',
    phone: '11999999999',
    cpf: '000.000.000-00',
    role: 'ADMIN',
  },
  {
    email: 'colaborador@bagfinder.com',
    password: 'colab1234!',
    fullName: 'João Colaborador',
    phone: '11888888888',
    cpf: '111.111.111-11',
    role: 'COLLABORATOR',
  },
  {
    email: 'usuario@bagfinder.com',
    password: 'user1234!',
    fullName: 'Maria Viajante',
    phone: '11777777777',
    cpf: '222.222.222-22',
    role: 'TRAVELER',
  },
];

async function seed() {
  for (const user of users) {
    try {
      const createdUser = await auth.createUser({
        email: user.email,
        password: user.password,
      });

      await firestore.collection('users').doc(createdUser.uid).set({
        id: createdUser.uid,
        email: user.email,
        fullName: user.fullName,
        phone: user.phone,
        cpf: user.cpf,
        type: user.role,
        isActive: true,
      });

      console.log(`✅ Usuário ${user.email} criado com sucesso.`);
    } catch (err) {
      console.error(`❌ Erro ao criar ${user.email}:`, err.message);
    }
  }
}

seed();
