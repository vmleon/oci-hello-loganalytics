import {check} from 'k6';
import http from 'k6/http';

export const options = {
  vus: 10,
  duration: '20s',
};

if (!__ENV.LB_PUBLIC_IP) {
  console.error('Invalid or empty LB_PUBLIC_IP environment variable');
  process.exit(1);
}

export default function () {
  const res = http.get(`http://${__ENV.LB_PUBLIC_IP}/hello`);
  check(res, {
    'Is 200 OK': (r) => r.status === 200,
    'Valid Response': (r) => r.body.includes('Hello'),
  });
}
